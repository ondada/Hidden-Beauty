package utility;

public class Paging {
	//페이징 관련 변수	
	private int totalCount = 0 ; //총 레코드 건수
	private int totalPage = 0 ; //전체 페이지 수
	private int pageNumber = 0 ; //보여줄 페이지 넘버
	private int pageSize = 0 ; //한 페이지에 보여줄 건수
	private int beginRow = 0 ; //현재 페이지의 시작 행
	private int endRow = 0 ; //현재 페이지의 끝 행
	private int pageCount = 3 ; // 한 화면에 보여줄 페이지 링크 수
	private int beginPage = 0 ; //페이징 처리 시작 페이지 번호
	private int endPage = 0 ; //페이징 처리 끝 페이지 번호
	private int offset = 0 ;
	private int limit = 0 ;
	private String url = "" ;//몇 페이지를 보든 list.ab를 요청 >>> list.ab를 요청하는 변수
	private String pagingHtml = "";//하단의 숫자 페이지 링크
	private String whatColumn = "" ; //검색 모드(작성자, 글제목)
	private String keyword = "" ; //검색할 단어 

	public int getTotalCount() {
		return totalCount;
	}


	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}


	public int getTotalPage() {
		return totalPage;
	}


	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}


	public int getPageNumber() {
		return pageNumber;
	}


	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}


	public int getPageSize() {
		return pageSize;
	}


	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}


	public int getBeginRow() {
		return beginRow;
	}


	public void setBeginRow(int beginRow) {
		this.beginRow = beginRow;
	}


	public int getEndRow() {
		return endRow;
	}


	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}


	public int getPageCount() {
		return pageCount;
	}


	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}


	public int getBeginPage() {
		return beginPage;
	}


	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}


	public int getEndPage() {
		return endPage;
	}


	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}


	public int getOffset() {
		return offset;
	}


	public void setOffset(int offset) {
		this.offset = offset;
	}


	public int getLimit() {
		return limit;
	}


	public void setLimit(int limit) {
		this.limit = limit;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}


	public String getPagingHtml() {
		//System.out.println("pagingHtml:"+pagingHtml);
		
		return pagingHtml;

	}


	public void setPagingHtml(String pagingHtml) {
		this.pagingHtml = pagingHtml;
	}

	public String getWhatColumn() {
		return whatColumn;
	}


	public void setWhatColumn(String whatColumn) {
		this.whatColumn = whatColumn;
	}


	public String getKeyword() { 
		return keyword;
	}


	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}


	public Paging(
			String _pageNumber, 
			String _pageSize,  
			int totalCount,
			String url, 
			String whatColumn, 
			String keyword) {	//,String whologin	

		if(  _pageNumber == null || _pageNumber.equals("null") || _pageNumber.equals("")  ){
			//System.out.println("_pageNumber:"+_pageNumber); // null
			_pageNumber = "1" ;
		}
		this.pageNumber = Integer.parseInt( _pageNumber ) ; 

		if( _pageSize == null || _pageSize.equals("null") || _pageSize.equals("") ){
			_pageSize = "5" ; 
		}		
		this.pageSize = Integer.parseInt( _pageSize ) ;
		
		this.limit = pageSize ; // 한 페이지에 보여줄 레코드 갯수

		this.totalCount = totalCount ; //총 페이지 수
								//Math.ceil >>> 실수 값 반 올림
		this.totalPage = (int)Math.ceil((double)this.totalCount / this.pageSize) ;
		
		this.beginRow = ( this.pageNumber - 1 )  * this.pageSize  + 1 ;
		this.endRow =  this.pageNumber * this.pageSize ;
		
		//삭제할 때 필요한 작업, 삭제 후에 이동할 위치
		if( this.pageNumber > this.totalPage ){
			this.pageNumber = this.totalPage ;
		}
		//건너 뛸 레코드 개수 : offset
		//if 3페이지를 볼 거면 4개를 건너 뛰어야 함
		this.offset = ( pageNumber - 1 ) * pageSize ; 
		
		if( this.endRow > this.totalCount ){
			this.endRow = this.totalCount  ;
		}
		//beginPage	: 보이는 시작 페이지, 만약 1페이지를 보고 있다면 1
		//endPage	: 보이는 끝 페이지, 만약 1페이지를 보고 있다면 3
		this.beginPage = ( this.pageNumber - 1 ) / this.pageCount * this.pageCount + 1  ;
		this.endPage = this.beginPage + this.pageCount - 1 ;
		
		//System.out.println("pageNumber:"+pageNumber+"/totalPage:"+totalPage);	
		
		if( this.endPage > this.totalPage ){
			this.endPage = this.totalPage ;
		}
		
		//System.out.println("pageNumber2:"+pageNumber+"/totalPage2:"+totalPage);	
		this.url = url ; //  /ex/list.ab
		this.whatColumn = whatColumn ;
		this.keyword = keyword ;
		System.out.println("whatColumn:"+whatColumn+"/keyword:"+keyword);
		
		//System.out.println("url2:"+url); //url2:/ex/list.ab
		this.pagingHtml = getPagingHtml(url) ;
		//맨처음 이전 123 [다음]맨 끝
	}//생성자
	
	// Ajax용 페이징 생성자
	public Paging(String pageNumber, int totalCount, String url) {
		System.out.println("Ajax Paging() 호출중 ...");
		if(pageNumber == null) {
			pageNumber = "1";
		}
		this.pageNumber = Integer.parseInt(pageNumber); 
//		if(pageSize == null) {
//			pageSize = "5";
//		}
		this.pageSize = 5; 
		// 굳이 ajax용 페이징 생성자 만들 필요 없긴 함. 원래 paging 생성자에 if문 추가하면 되는데 시간상 나중에..
		this.limit = this.pageSize; // 한 페이지에 보여줄 레코드 갯수

		this.totalCount = totalCount ; //총 페이지 수
								//Math.ceil >>> 실수 값 반 올림
		this.totalPage = (int)Math.ceil((double)this.totalCount / this.pageSize) ;
		
		this.beginRow = ( this.pageNumber - 1 )  * this.pageSize  + 1 ;
		this.endRow =  this.pageNumber * this.pageSize ;
		
		//삭제할 때 필요한 작업, 삭제 후에 이동할 위치
		if( this.pageNumber > this.totalPage ){
			this.pageNumber = this.totalPage ;
		}
		//건너 뛸 레코드 개수 : offset
		//if 3페이지를 볼 거면 4개를 건너 뛰어야 함
		this.offset = (this.pageNumber - 1) * this.pageSize ; 
		
		if( this.endRow > this.totalCount ){
			this.endRow = this.totalCount  ;
		}
		//beginPage	: 보이는 시작 페이지, 만약 1페이지를 보고 있다면 1
		//endPage	: 보이는 끝 페이지, 만약 1페이지를 보고 있다면 3
		this.beginPage = ( this.pageNumber - 1 ) / this.pageCount * this.pageCount + 1  ;
		this.endPage = this.beginPage + this.pageCount - 1 ;
		
		if( this.endPage > this.totalPage ){
			this.endPage = this.totalPage ;
		}
		//this.url = url ; 
		System.out.println("this.pageNumber:"+this.pageNumber);
		System.out.println("this.pageSize:"+this.pageSize);
		System.out.println("this.offset:"+this.offset);
		System.out.println("this.limit:"+this.limit);
		this.pagingHtml = getAjaxPagingHtml(url) ;
	}
	
	private String getAjaxPagingHtml(String url) {
		System.out.println("getAjaxPagingHtml() 함수 호출중...");
		String result = "" ;
		if (this.beginPage != 1) {
			result += "&nbsp;<a href='javascript:ajax(\""+url+"\", 1)' style='text-decoration: none; color: black;'>[처음으로]</a>&nbsp;";
			result += "&nbsp;<a href='javascript:ajax(\""+url+"\", "+(this.beginPage-1)+")' style='text-decoration: none; color: black;'>[이전]</a>&nbsp;";
		}
		//가운데
		for (int i = this.beginPage; i <= this.endPage ; i++) {
			if ( i == this.pageNumber ) {
				result += "&nbsp;<font style='text-decoration: none; background: #7C81BB; font-size: 10pt;'>&nbsp;"+ i +"&nbsp;</font>";
						
			} else {
				result += "&nbsp;<a href='javascript:ajax(\""+url+"\", "+ i +")' style='text-decoration: none; color: black;'>&nbsp;"+ i +"&nbsp;</a>";
			}
		}
		//다음, 맨 끝
		if ( this.endPage != this.totalPage) { 
			result += "&nbsp;<a href='javascript:ajax(\""+url+"\", "+ (this.endPage+1) +")' style='text-decoration: none; color: black;'>[다음]</a>&nbsp;";
			result += "&nbsp;<a href='javascript:ajax(\""+url+"\", "+ this.totalPage +")' style='text-decoration: none; color: black;'>[맨 끝으로]</a>&nbsp;";
		}
		System.out.println("pagingHtml: "+result);
		return result ;
	}


	private String getPagingHtml( String url ){ //페이징 문자열을 만든다.
//		System.out.println("getPagingHtml url:"+url); 
		
		String result = "" ;
		String added_param = "&whatColumn=" + whatColumn + "&keyword=" + keyword ;
		
		//맨 처음, 이전		 beginPage가 1페이지가 아닐 때
		if (this.beginPage != 1) {
			result += "&nbsp;<a href='" + url  
					+ "?pageNumber=" + ( 1 ) + "&pageSize=" + this.pageSize 
					+ added_param + "' style='text-decoration: none; color: black;'>[처음으로]</a>&nbsp;" ;
			result += "&nbsp;<a href='" + url 
					+ "?pageNumber=" + (this.beginPage - 1 ) + "&pageSize=" + this.pageSize 
					+ added_param + "' style='text-decoration: none; color: black;'>[이전]</a>&nbsp;" ;
		}
		
		//가운데
		for (int i = this.beginPage; i <= this.endPage ; i++) {
			if ( i == this.pageNumber ) {
				result += "&nbsp;<font style='text-decoration: none; background: #EDE5D8; font-size: 10pt;'>&nbsp;" + i + "&nbsp;</font>"	;
						
			} else {
				result += "&nbsp;<a href='" + url   
						+ "?pageNumber=" + i + "&pageSize=" + this.pageSize 
						+ added_param + "' style='text-decoration: none; color: black; font-size: 10pt;'>&nbsp;" + i + "&nbsp;</a>" ;
			}
		}
		
//		System.out.println("result:"+result); 
//		System.out.println(); 
		//다음, 맨 끝
		if ( this.endPage != this.totalPage) { 
			
			result += "&nbsp;<a href='" + url  
					+ "?pageNumber=" + (this.endPage + 1 ) + "&pageSize=" + this.pageSize 
					+ added_param + "' style='text-decoration: none; color: black;'>[다음]</a>&nbsp;" ;
			
			result += "&nbsp;<a href='" + url  
					+ "?pageNumber=" + (this.totalPage ) + "&pageSize=" + this.pageSize 
					+ added_param + "' style='text-decoration: none; color: black;'>[맨 끝으로]</a>&nbsp;" ;
		}		
//		System.out.println("result2:"+result);
		
		return result ;
	}	
	
}