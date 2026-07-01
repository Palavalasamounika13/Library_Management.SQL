CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;

-- Drop existing tables to ensure a clean start
DROP TABLE IF EXISTS tbl_book_authors, tbl_book_copies, tbl_book_loans, tbl_book, tbl_publisher, tbl_library_branch, tbl_borrower;

CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(255) PRIMARY KEY,
    publisher_PublisherAddress VARCHAR(255),
    publisher_PublisherPhone VARCHAR(255)
);

CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT PRIMARY KEY AUTO_INCREMENT,
    library_branch_BranchName VARCHAR(255),
    library_branch_BranchAddress VARCHAR(255)
);

CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY,
    book_Title VARCHAR(255),
    book_PublisherName VARCHAR(255),
    FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(255),
    FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_borrower (
    borrower_CardNo INT PRIMARY KEY,
    borrower_BorrowerName VARCHAR(255),
    borrower_BorrowerAddress VARCHAR(255),
    borrower_BorrowerPhone VARCHAR(255)
);

CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT PRIMARY KEY AUTO_INCREMENT,
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT,
    FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT PRIMARY KEY AUTO_INCREMENT,
    book_loans_BookID INT,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut DATE,
    book_loans_DueDate DATE,
    FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Publishers
INSERT INTO tbl_publisher VALUES ('DAW Books', '375 Hudson Street, New York, NY 10014', '212-366-2000'), ('Viking', '375 Hudson Street, New York, NY 10014', '212-366-2000'), ('Signet Books', '375 Hudson Street, New York, NY 10014', '212-366-2000'), ('Chilton Books', 'Not Available', 'Not Available'), ('George Allen & Unwin', '83 Alexander Ln, Crows Nest NSW 2065, Australia', '-8466'), ('Alfred A. Knopf', '1745 Broadway, New York, NY 10019', '212-940-7390'), ('Bloomsbury', '1385 Broadway, New York, NY 10018', '212-419-5300'), ('Shinchosa', 'Tokyo 101-0064 Japan', '-12006'), ('Harper and Row', '195 Broadway, New York, NY 10007', '212-207-7000'), ('Pan Books', '175 Fifth Avenue, New York, NY 10010', '646-307-5745'), ('Chalto & Windus', '375 Hudson Street, New York, NY 10014', '212-366-2000'), ('Harcourt Brace Jovanovich', '3 Park Ave, New York, NY 10016', '212-420-5800'), ('W.W. Norton', '500 Fifth Avenue, New York, NY 10110', '212-354-5500'), ('Scholastic', '557 Broadway, New York, NY 10012', '800-724-6527'), ('Bantam', '375 Hudson Street, New York, NY 10014', '212-366-2000'), ('Picador USA', '175 Fifth Avenue, New York, NY 10010', '646-307-5745');

-- Library Branches (Order matches IDs 1, 2, 3, 4)
INSERT INTO tbl_library_branch (library_branch_BranchName, library_branch_BranchAddress) VALUES ('Sharpstown', '32 Corner Road'), ('Central', '491 3rd Street'), ('Saline', '40 State Street'), ('Ann Arbor', '101 South University');

-- Borrowers
INSERT INTO tbl_borrower VALUES (100, 'Joe Smith', '1321 4th Street, New York, NY 10014', '212-312-1234'), (101, 'Jane Smith', '1321 4th Street, New York, NY 10014', '212-931-4124'), (102, 'Tom Li', '981 Main Street, Ann Arbor, MI 48104', '734-902-7455'), (103, 'Angela Thompson', '2212 Green Avenue, Ann Arbor, MI 48104', '313-591-2122'), (104, 'Harry Emnace', '121 Park Drive, Ann Arbor, MI 48104', '412-512-5522'), (105, 'Tom Haverford', '23 75th Street, New York, NY 10014', '212-631-3418'), (106, 'Haley Jackson', '231 52nd Avenue New York, NY 10014', '212-419-9935'), (107, 'Michael Horford', '653 Glen Avenue, Ann Arbor, MI 48104', '734-998-1513');

-- Books
INSERT INTO tbl_book VALUES (1, 'The Name of the Wind', 'DAW Books'), (2, 'It', 'Viking'), (3, 'The Green Mile', 'Signet Books'), (4, 'Dune', 'Chilton Books'), (5, 'The Hobbit', 'George Allen & Unwin'), (6, 'Eragon', 'Alfred A. Knopf'), (7, 'A Wise Mans Fear', 'DAW Books'), (8, 'Harry Potter and the Philosophers Stone', 'Bloomsbury'), (9, 'Hard Boiled Wonderland and The End of the World', 'Shinchosa'), (10, 'The Giving Tree', 'Harper and Row'), (11, 'The Hitchhikers Guide to the Galaxy', 'Pan Books'), (12, 'Brave New World', 'Chalto & Windus'), (13, 'The Princess Bride', 'Harcourt Brace Jovanovich'), (14, 'Fight Club', 'W.W. Norton'), (15, 'Holes', 'Scholastic'), (16, 'Harry Potter and the Chamber of Secrets', 'Bloomsbury'), (17, 'Harry Potter and the Prisoner of Azkaban', 'Bloomsbury'), (18, 'The Fellowship of the Ring', 'George Allen & Unwin'), (19, 'A Game of Thrones', 'Bantam'), (20, 'The Lost Tribe', 'Picador USA');

-- Authors
INSERT INTO tbl_book_authors (book_authors_BookID, book_authors_AuthorName) VALUES (1, 'Patrick Rothfuss'), (2, 'Stephen King'), (3, 'Stephen King'), (4, 'Frank Herbert'), (5, 'J.R.R. Tolkien'), (6, 'Christopher Paolini'), (6, 'Patrick Rothfuss'), (8, 'J.K. Rowling'), (9, 'Haruki Murakami'), (10, 'Shel Silverstein'), (11, 'Douglas Adams'), (12, 'Aldous Huxley'), (13, 'William Goldman'), (14, 'Chuck Palahniuk'), (15, 'Louis Sachar'), (16, 'J.K. Rowling'), (17, 'J.K. Rowling'), (18, 'J.R.R. Tolkien'), (19, 'George R.R. Martin'), (20, 'Mark Lee');

-- Book Copies (20 books x 4 branches)
-- (Shortened for brevity, but IDs 1-20 for books and 1-4 for branches must be present)
INSERT INTO tbl_book_copies (book_copies_BookID, book_copies_BranchID, book_copies_No_Of_Copies) 
SELECT b.book_BookID, lb.library_branch_BranchID, 5 
FROM tbl_book b CROSS JOIN tbl_library_branch lb;

-- Book Loans (Dates corrected to YYYY-MM-DD)
INSERT INTO tbl_book_loans (book_loans_BookID, book_loans_BranchID, book_loans_CardNo, book_loans_DateOut, book_loans_DueDate) VALUES 
(1, 1, 100, '2018-01-01', '2018-02-02'), (2, 1, 100, '2018-01-01', '2018-02-02'), (3, 1, 100, '2018-01-01', '2018-02-02'), (4, 1, 100, '2018-01-01', '2018-02-02'),
(5, 1, 102, '2018-01-03', '2018-02-03'), (6, 1, 102, '2018-01-03', '2018-02-03'), (7, 1, 102, '2018-01-03', '2018-02-03'), (8, 1, 102, '2018-01-03', '2018-02-03'),
(9, 1, 102, '2018-01-03', '2018-02-03'), (11, 1, 102, '2018-01-03', '2018-02-03'), (20, 2, 105, '2018-02-03', '2018-03-03');

-- 1.How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
SELECT bc.book_copies_No_Of_Copies
FROM tbl_book_copies bc
JOIN tbl_book b ON bc.book_copies_BookID = b.book_BookID
JOIN tbl_library_branch lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE b.book_Title = 'The Lost Tribe' AND lb.library_branch_BranchName = 'Sharpstown';
-- 2.How many copies of the book titled "The Lost Tribe" are owned by each library branch?
SELECT lb.library_branch_BranchName, bc.book_copies_No_Of_Copies
FROM tbl_book_copies bc
JOIN tbl_book b ON bc.book_copies_BookID = b.book_BookID
JOIN tbl_library_branch lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE b.book_Title = 'The Lost Tribe';
-- 3.Retrieve the names of all borrowers who do not have any books checked out.
SELECT borrower_BorrowerName
FROM tbl_borrower
WHERE borrower_CardNo NOT IN (SELECT DISTINCT book_loans_CardNo FROM tbl_book_loans);
-- 4.For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address.
SELECT b.book_Title, br.borrower_BorrowerName, br.borrower_BorrowerAddress
FROM tbl_book_loans bl
JOIN tbl_book b ON bl.book_loans_BookID = b.book_BookID
JOIN tbl_borrower br ON bl.book_loans_CardNo = br.borrower_CardNo
JOIN tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_BranchID
WHERE lb.library_branch_BranchName = 'Sharpstown' AND bl.book_loans_DueDate = '2018-02-03';
-- 5.For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
SELECT lb.library_branch_BranchName, COUNT(bl.book_loans_LoansID) AS Total_Loans
FROM tbl_library_branch lb
LEFT JOIN tbl_book_loans bl ON lb.library_branch_BranchID = bl.book_loans_BranchID
GROUP BY lb.library_branch_BranchName;
-- 6.Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
SELECT br.borrower_BorrowerName, br.borrower_BorrowerAddress, COUNT(bl.book_loans_LoansID) AS Books_Checked_Out
FROM tbl_borrower br
JOIN tbl_book_loans bl ON br.borrower_CardNo = bl.book_loans_CardNo
GROUP BY br.borrower_BorrowerName, br.borrower_BorrowerAddress
HAVING COUNT(bl.book_loans_LoansID) > 5;
-- 7.For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
SELECT b.book_Title, bc.book_copies_No_Of_Copies
FROM tbl_book b
JOIN tbl_book_authors ba ON b.book_BookID = ba.book_authors_BookID
JOIN tbl_book_copies bc ON b.book_BookID = bc.book_copies_BookID
JOIN tbl_library_branch lb ON bc.book_copies_BranchID = lb.library_branch_BranchID
WHERE ba.book_authors_AuthorName = 'Stephen King' AND lb.library_branch_BranchName = 'Central';