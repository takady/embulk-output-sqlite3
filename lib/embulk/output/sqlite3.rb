module Embulk
  module Output
    require 'jdbc/sqlite3'
    Jdbc::SQLite3.load_driver

    class Sqlite3OutputPlugin < OutputPlugin
      Plugin.register_output("sqlite3", self)

      def self.transaction(config, schema, count, &control)
        columns = schema.map {|c| "`#{c.name}`" }
        column_types = schema.map {|c| "#{to_sqlite_column_type(c.type.to_s)}" }

        task = {
          'database' => config.param('database', :string),
          'table' => config.param('table', :string),
          'columns' => columns,
          'column_types' => column_types,
        }

        connect(task) do |sqlite|
          execute_sql(sqlite, %[create table if not exists #{task['table']}(#{to_sqlite_schema(schema)})])
        end

        # resumable output:
        # resume(task, schema, count, &control)

        # non-resumable output:
        commit_reports = yield(task)
        next_config_diff = {}
        return next_config_diff
      end

      def self.to_sqlite_schema(schema)
        schema.map {|column| "`#{column.name}` #{to_sqlite_column_type(column.type.to_s)}" }.join(',')
      end

      def self.to_sqlite_column_type(type)
        case type
        when 'long' then
          'integer'
        when 'string' then
          'text'
        when 'timestamp' then
          'text'
        else
          type
        end
      end

      def self.connect(task)
        url = "jdbc:sqlite:#{task['database']}"
        sqlite = org.sqlite.JDBC.new.connect(url, java.util.Properties.new)
        if block_given?
          begin
            yield sqlite
          ensure
            sqlite.close
          end
        end
        sqlite
      end

      def self.execute_sql(sqlite, sql, *args)
        stmt = sqlite.createStatement
        begin
          stmt.execute(sql)
        ensure
          stmt.close
        end
      end

      #def self.resume(task, schema, count, &control)
      #  commit_reports = yield(task)
      #
      #  next_config_diff = {}
      #  return next_config_diff
      #end

      def init
        # initialization code:
        @sqlite = self.class.connect(task)
        @records = 0
      end

      def close
        @sqlite.close
      end

      def add(page)
        prep = @sqlite.prepareStatement(%[insert into #{@task['table']}(#{@task['columns'].join(',')}) values (#{@task['columns'].map{|c| '?' }.join(',')})])
        begin
          page.each do |record|

            @task['column_types'].each_with_index do |type, index|
              case type
              when 'integer' then
                prep.setInt(index+1, record[index])
              when 'string' then
                prep.setString(index+1, record[index])
              when 'timestamp' then
                prep.setString(index+1, record[index].to_s)
              else
                prep.setString(index+1, record[index].to_s)
              end
            end

            prep.execute
            @records += 1
          end
        ensure
          prep.close
        end
      end

      def finish
      end

      def abort
      end

      def commit
        commit_report = {
          "records" => @records          
        }
        return commit_report
      end
    end

  end
end
