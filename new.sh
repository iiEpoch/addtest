read -p "test_path:" test_path
read -p "report_path:" report_path

#data_path
path="/mnt/nvme4"

value_size=512

rm -rf ${path}/${value_size}B

mkdir ${path}/${value_size}B

for dataset in {200,400,600}
do	
	echo "创建${dataset}G-${value_size}B数据集"
	./writedata.sh ${path} ${dataset} ${value_size}
	sleep 10
done

value=512

data_path="/mnt/nvme4"

disable_wal="false"

for dataset in {200,400,600}
	do	
		echo "创建测试目录${test_path}"
		mkdir ${test_path}

		cp -r ${data_path}/${value}B/${dataset}G/* ${test_path}
		echo "复制${data_path}/${value}B/${dataset}G到${test_path}"

		sleep 10
	
		echo "进行测试写${dataset}G-value${value}-Disable_Wal-${disable_wal}"


		./overwrite.sh ${test_path} ${dataset} ${value} ${report_path} ${disable_wal}
		

		sleep 5

		echo "本次测试完成删除test目录"
		rm -rf ${test_path}
		sleep 10

	done