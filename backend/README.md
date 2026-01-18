# Taskman Backend

## 技術スタック

- Kotlin
- Spring Boot 3.5.9
- Java 21
- Gradle

## アーキテクチャ

DDDレイヤードアーキテクチャを採用

- **Domain層**: ビジネスロジック・集約・値オブジェクト
- **Application層**: ユースケース・DTO
- **Infrastructure層**: 永続化・外部サービス連携
- **Presentation層**: REST API・リクエスト/レスポンス

## 前提条件

- Java 21

## セットアップ

```bash
./gradlew build
```

## 実行方法

```bash
./gradlew bootRun
```

## テスト

```bash
./gradlew test
```

## APIエンドポイント

| Method | Endpoint | 説明 |
|--------|----------|------|
| GET | /tasks | タスク一覧取得 |
| GET | /tasks/{id} | タスク詳細取得 |
| POST | /tasks | タスク作成 |
| PUT | /tasks/{id} | タスク更新 |
| DELETE | /tasks/{id} | タスク削除 |

## ディレクトリ・ファイル構成

```
src/
└── main/
└── kotlin/
└── com/
└── example/
└── springdddexample/
├── domain/                           # ドメイン層
│   ├── model/
│   │   └── task/                     # Task集約
│   │       ├── Task.kt               # 集約ルート
│   │       ├── TaskId.kt             # 値オブジェクト（ULID）
│   │       ├── TaskName.kt           # 値オブジェクト
│   │       ├── TaskStatus.kt         # 値オブジェクト（Enum）
│   │       └── TaskRepository.kt     # リポジトリIF（ポート）
│   └── shared/                       # 共有カーネル
│       └── DomainException.kt        # ドメイン例外の基底クラス
├── application/                      # アプリケーション層（ユースケース）
│   ├── service/
│   │   └── task/
│   │       └── TaskApplicationService.kt
│   └── dto/
│       └── task/
│           ├── CreateTaskInput.kt
│           ├── UpdateTaskInput.kt
│           ├── CompleteTaskInput.kt
│           └── TaskOutput.kt
├── infrastructure/                   # インフラストラクチャ層
│   └── persistence/
│       └── jpa/
│           ├── entity/               # JPAエンティティ
│           │   └── task/
│           │       └── TaskJpaEntity.kt
│           ├── repository/           # Spring Data JPA
│           │   └── task/
│           │       └── TaskJpaRepository.kt
│           ├── adapter/              # リポジトリアダプター
│           │   └── task/
│           │       └── TaskRepositoryAdapter.kt
│           ├── mapper/               # ドメイン⇔JPA変換
│           │   └── task/
│           │       └── TaskMapper.kt
│           └── config/
│               └── JpaConfig.kt
└── presentation/                     # プレゼンテーション層
├── rest/
│   └── task/
│       └── TaskController.kt
├── dto/
│   └── task/
│       ├── CreateTaskRequest.kt      # toInput()拡張関数を含む
│       ├── UpdateTaskRequest.kt      # toInput()拡張関数を含む
│       ├── TaskResponse.kt           # from()ファクトリ関数を含む
│       └── TaskListResponse.kt       # from()ファクトリ関数を含む
├── exception/
│   ├── GlobalExceptionHandler.kt
│   └── ErrorResponse.kt
└── config/
├── WebConfig.kt
└── OpenApiConfig.kt
```