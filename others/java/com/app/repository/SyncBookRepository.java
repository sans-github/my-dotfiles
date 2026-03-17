package com.app.repository;

import java.util.List;

import com.app.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SyncBookRepository extends JpaRepository<Book, Long> {
	List<Book> findByPublished(boolean published);
	List<Book> findByTitleContaining(String title);
}
