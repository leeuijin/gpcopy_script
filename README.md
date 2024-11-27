## 1.사용방법  ##

 	git clone https://github.com/leeuijin/gpcopy_script
  	cd ./gpcopy_script
   	chmod +x *.sh
    	sh 5_gpcopy_all.sh
	
## 2.파일 내용 요약 ##

	0_gpcopy_init.sh 		: 작업 디렉토리 생성 및 로그 기존 로그 삭제 
	1_tbl_size_report.sh		: ./sql 경로의 쿼리를 실행하여 리포트 작성
					파티션 테이블과 비파티션 테이블로 별도로 리포트를 생성
					테이블 사이즈 기준으로 정(인덱스 제외)
					테이블 사이즈 및 압축 유무, 압축 타입, 레벨 확인 가능
					외부 테이블 제외,크기순으로 정렬

	2_gen_include_table_file.sh 	: gpcopy 에서 --include-table-file 로 사용할 수 있도록 대상 테이블 목록 파일 생성 (파티션/비파티션)
	3_gpcopy_non_prt_all.sh     	: 2_gen_include_table_file.sh 에서 생성된 파일중 비파티션 테이블 대상으로 gpcopy 실행 	(기본 옵션 : truncate,validate count, jobs 8, analyze)
	4_gpcopy_prt_all.sh         	: 2_gen_include_table_file.sh 에서 생성된 파일중 파티션 테이블 대상으로 gpcopy 실행 	(기본 옵션 : truncate,validate count, jobs 8, analyze)
	5_gpcopy_all.sh             	: 0~4번 스크립트를 일괄 실행

## 3.디렉토리 설명 ##

	./include-table-file        : gpcopy 대상 테이블 파일 
	./logs                      : 작업로그 
	./report                    : 1_tbl_size_report.sh 실행 결과      
	./sql                       : report 및 gpcopy 대상 테이블 추출 쿼리 
