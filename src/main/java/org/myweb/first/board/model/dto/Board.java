package org.myweb.first.board.model.dto;

import java.sql.Date;

public class Board implements java.io.Serializable {
	private static final long serialVersionUID = -6086290596677675589L;

	private int boardNum;
	private String boardWriter;
	private String boardTitle;
	private String boardContent;
	private String boardOriginalFilename;
	private String boardRenameFilename;
	private int boardRef;
	private int boardReplyRef;
	private int boardLev;
	private int boardReplySeq;
	private int boardReadcount;
	private Date boardDate;

	public Board() {
		super();
	}

	public Board(int boardNum, String boardWriter, String boardTitle, String boardContent, String boardOriginalFilename,
			String boardRenameFilename, int boardRef, int boardReplyRef, int boardLev, int boardReplySeq,
			int boardReadcount, Date boardDate) {
		super();
		this.boardNum = boardNum;
		this.boardWriter = boardWriter;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.boardOriginalFilename = boardOriginalFilename;
		this.boardRenameFilename = boardRenameFilename;
		this.boardRef = boardRef;
		this.boardReplyRef = boardReplyRef;
		this.boardLev = boardLev;
		this.boardReplySeq = boardReplySeq;
		this.boardReadcount = boardReadcount;
		this.boardDate = boardDate;
	}

	public int getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}

	public String getBoardWriter() {
		return boardWriter;
	}

	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public String getBoardOriginalFilename() {
		return boardOriginalFilename;
	}

	public void setBoardOriginalFilename(String boardOriginalFilename) {
		this.boardOriginalFilename = boardOriginalFilename;
	}

	public String getBoardRenameFilename() {
		return boardRenameFilename;
	}

	public void setBoardRenameFilename(String boardRenameFilename) {
		this.boardRenameFilename = boardRenameFilename;
	}

	public int getBoardRef() {
		return boardRef;
	}

	public void setBoardRef(int boardRef) {
		this.boardRef = boardRef;
	}

	public int getBoardReplyRef() {
		return boardReplyRef;
	}

	public void setBoardReplyRef(int boardReplyRef) {
		this.boardReplyRef = boardReplyRef;
	}

	public int getBoardLev() {
		return boardLev;
	}

	public void setBoardLev(int boardLev) {
		this.boardLev = boardLev;
	}

	public int getBoardReplySeq() {
		return boardReplySeq;
	}

	public void setBoardReplySeq(int boardReplySeq) {
		this.boardReplySeq = boardReplySeq;
	}

	public int getBoardReadcount() {
		return boardReadcount;
	}

	public void setBoardReadcount(int boardReadcount) {
		this.boardReadcount = boardReadcount;
	}

	public Date getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Board [boardNum=" + boardNum + ", boardWriter=" + boardWriter + ", boardTitle=" + boardTitle
				+ ", boardContent=" + boardContent + ", boardOriginalFilename=" + boardOriginalFilename
				+ ", boardRenameFilename=" + boardRenameFilename + ", boardRef=" + boardRef + ", boardReplyRef="
				+ boardReplyRef + ", boardLev=" + boardLev + ", boardReplySeq=" + boardReplySeq + ", boardReadcount="
				+ boardReadcount + ", boardDate=" + boardDate + "]";
	}

}
