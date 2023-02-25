// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Post {
  final String id;
  final String caption;
  final String altText;
  final String link;
  final String username;
  final String profilepic;
  final List<String> likes;
  final List<String> dislikes;
  final int commentCount;
  final String uid;
  final DateTime createdAt;
  Post({
    required this.id,
    required this.caption,
    required this.altText,
    required this.link,
    required this.username,
    required this.profilepic,
    required this.likes,
    required this.dislikes,
    required this.commentCount,
    required this.uid,
    required this.createdAt,
  });

  Post copyWith({
    String? id,
    String? caption,
    String? altText,
    String? link,
    String? username,
    String? profilepic,
    List<String>? likes,
    List<String>? dislikes,
    int? commentCount,
    String? uid,
    DateTime? createdAt,
  }) {
    return Post(
      id: id ?? this.id,
      caption: caption ?? this.caption,
      altText: altText ?? this.altText,
      link: link ?? this.link,
      username: username ?? this.username,
      profilepic: profilepic ?? this.profilepic,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      commentCount: commentCount ?? this.commentCount,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'caption': caption,
      'altText': altText,
      'link': link,
      'username': username,
      'profilepic': profilepic,
      'likes': likes,
      'dislikes': dislikes,
      'commentCount': commentCount,
      'uid': uid,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      caption: map['caption'] as String,
      altText: map['altText'] as String,
      link: map['link'] as String,
      username: map['username'] as String,
      profilepic: map['profilepic'] as String,
      likes: List<String>.from((map['likes'] as List)),
      dislikes: List<String>.from((map['dislikes'] as List)),
      commentCount: map['commentCount'] as int,
      uid: map['uid'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(id: $id, caption: $caption, altText: $altText, link: $link, username: $username, profilepic: $profilepic, likes: $likes, dislikes: $dislikes, commentCount: $commentCount, uid: $uid, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.caption == caption &&
        other.altText == altText &&
        other.link == link &&
        other.username == username &&
        other.profilepic == profilepic &&
        listEquals(other.likes, likes) &&
        listEquals(other.dislikes, dislikes) &&
        other.commentCount == commentCount &&
        other.uid == uid &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        caption.hashCode ^
        altText.hashCode ^
        link.hashCode ^
        username.hashCode ^
        profilepic.hashCode ^
        likes.hashCode ^
        dislikes.hashCode ^
        commentCount.hashCode ^
        uid.hashCode ^
        createdAt.hashCode;
  }
}
