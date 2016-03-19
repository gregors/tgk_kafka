require "tgk/version"

module TGK
  module Kafka
    class Server
      def run
        #FileUtils.cd(solr_executable_directory) { exec(*command) }
        puts 'running'
        command = %w[

java
-Xmx512M
-Xms512M
-server
-XX:+UseParNewGC
-XX:+UseConcMarkSweepGC
-XX:+CMSClassUnloadingEnabled
-XX:+CMSScavengeBeforeRemark
-XX:+DisableExplicitGC
-Djava.awt.headless=true
-Xloggc:/home/gregors/tgk_kafka/kafka/bin/../logs/zookeeper-gc.log
-verbose:gc
-XX:+PrintGCDetails
-XX:+PrintGCDateStamps
-XX:+PrintGCTimeStamps
-Dcom.sun.management.jmxremote
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
-Dkafka.logs.dir=/home/gregors/tgk_kafka/kafka/bin/../logs
-Dlog4j.configuration=file:kafka/bin/../config/log4j.properties
-cp
:/home/gregors/tgk_kafka/kafka/bin/../core/build/dependant-libs-2.10.4*/*.jar:/home/gregors/tgk_kafka/kafka/bin/../examples/build/libs//kafka-examples*.jar:/home/gregors/tgk_kafka/kafka/bin/../contrib/hadoop-consumer/build/libs//kafka-hadoop-consumer*.jar:/home/gregors/tgk_kafka/kafka/bin/../contrib/hadoop-producer/build/libs//kafka-hadoop-producer*.jar:/home/gregors/tgk_kafka/kafka/bin/../clients/build/libs/kafka-clients*.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/jopt-simple-3.2.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/kafka_2.10-0.8.2.1.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/kafka_2.10-0.8.2.1-javadoc.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/kafka_2.10-0.8.2.1-scaladoc.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/kafka_2.10-0.8.2.1-sources.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/kafka_2.10-0.8.2.1-test.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/kafka-clients-0.8.2.1.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/log4j-1.2.16.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/lz4-1.2.0.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/metrics-core-2.2.0.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/scala-library-2.10.4.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/slf4j-api-1.7.6.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/slf4j-log4j12-1.6.1.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/snappy-java-1.1.1.6.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/zkclient-0.3.jar:/home/gregors/tgk_kafka/kafka/bin/../libs/zookeeper-3.4.6.jar:/home/gregors/tgk_kafka/kafka/bin/../core/build/libs/kafka_2.10*.jar
org.apache.zookeeper.server.quorum.QuorumPeerMain kafka/config/zookeeper.properties
        ]
        pid = fork do
          exec(*command)
        end
        File.open(zookeeper_pid_path, 'w') do |file|
          file << pid
        end
        sleep 1
        puts ">>>>>>>>>" + pid.to_s
      end

      def zookeeper_pid_path
          File.join(Dir.pwd, 'zookeeper.pid')
      end

      def zookeeper_pid
        begin
          IO.read(zookeeper_pid_path)
        rescue
          nil 
        end
      end
    end
  end
end
