# SEAT-HUNTER

> AI 청중과 함께 실제 발표 상황을 연습하고, 말하기 데이터를 바탕으로 피드백을 받는 발표 시뮬레이션 서비스입니다.

SEAT-HUNTER는 발표 전 긴장을 줄이고 실전 대응력을 높이기 위한 웹 애플리케이션입니다. 사용자는 발표 환경과 청중 유형, 난이도, 시간을 설정한 뒤 가상 청중 앞에서 발표를 진행합니다. 발표 중에는 음성 인식 기반의 실시간 지표와 AI 청중의 질문·반응을 확인할 수 있으며, 종료 후에는 세션 리포트와 연습 이력을 통해 개선점을 살펴볼 수 있습니다.<br><br>
<img width="3000" height="1680" alt="page-0001" src="https://github.com/user-attachments/assets/49aefb92-50af-4ff7-8fda-b8ba27bd02e8" />
<img width="3000" height="1680" alt="page-0002" src="https://github.com/user-attachments/assets/87d1da7f-28aa-4e9a-9e82-3267022c2e80" />
<img width="3000" height="1680" alt="page-0003" src="https://github.com/user-attachments/assets/1d43595a-f22f-4453-b739-dcbe765d6f0f" />
<img width="3000" height="1680" alt="page-0004" src="https://github.com/user-attachments/assets/fae2ba70-8c67-4e8a-86d1-3b19360c966d" />
<img width="3000" height="1680" alt="page-0005" src="https://github.com/user-attachments/assets/d1e68a51-81ea-46e3-b2e6-557c53e93655" />
<img width="3000" height="1680" alt="page-0006" src="https://github.com/user-attachments/assets/584be534-2af6-4f91-b786-b584ae9c56b7" />
<img width="3000" height="1680" alt="page-0008" src="https://github.com/user-attachments/assets/913aa876-8c00-4577-8414-9c7f7c852f3e" />


## 주요 기능

- **발표 환경 시뮬레이션**: 학술 발표, 학교 발표, 비즈니스 회의 환경을 제공합니다.
- **맞춤형 청중 설정**: 교수, 투자자, 상사, 일반 청중을 선택하고 인원과 압박 강도를 조절할 수 있습니다.
- **실시간 음성 분석**: 브라우저 음성 인식으로 발화 내용을 받아 말하기 속도(WPM), 필러 단어, 경과 시간을 추적합니다.
- **AI 청중 인터랙션**: 발표 내용에 따른 청중 반응과 질문·답변 흐름을 제공해 돌발 상황을 연습할 수 있습니다.
- **세션 리포트**: 발표 종료 후 점수, 말하기 속도 추이, 필러 단어, 인터럽트, 질문·답변 내용을 확인합니다.
- **연습 히스토리**: 이전 세션을 필터링하고 성과 변화를 확인할 수 있습니다.
- **인증**: 회원가입과 로그인 후 개인 세션을 관리합니다.

## 화면 흐름

```text
홈 → 로그인/회원가입 → 발표 설정 → 발표 시뮬레이션 → 결과 리포트 → 연습 히스토리
```

## 기술 스택

| 구분 | 기술 |
| --- | --- |
| Frontend | React 19, Vite 8 |
| Styling | CSS |
| 실시간 통신 | WebSocket |
| 음성 입력 | Web Speech API (`SpeechRecognition`) |
| Backend 연동 | REST API, WebSocket API |
| 품질 도구 | ESLint, Playwright |

## 프로젝트 구조

```text
SEAT-HUNTER/
├── frontend/
│   ├── public/                 # 파비콘, 발표 환경 이미지 등 정적 리소스
│   ├── src/
│   │   ├── assets/             # 프런트엔드 에셋
│   │   ├── pages/              # 홈, 설정, 시뮬레이션, 리포트, 히스토리 화면
│   │   ├── services/           # REST/WebSocket API 통신
│   │   ├── styles/             # 전역 스타일
│   │   ├── App.jsx             # 화면 전환 및 세션 상태 관리
│   │   └── main.jsx            # 애플리케이션 진입점
│   └── package.json
└── README.md
```

## 실행 방법

### 요구 사항

- Node.js 20 이상 권장
- npm
- API 및 WebSocket을 제공하는 SEAT-HUNTER 백엔드
- 마이크 권한을 지원하는 최신 브라우저

### 1. 프런트엔드 설치 및 실행

```bash
cd frontend
npm install
npm run dev
```

Vite가 출력하는 로컬 주소(일반적으로 `http://localhost:5173`)로 접속합니다.

### 2. 백엔드 주소 설정

기본적으로 프런트엔드는 `http://localhost:8000`의 API와 `ws://localhost:8000`의 WebSocket 서버에 연결합니다. 다른 주소를 사용할 경우 `frontend/.env.local` 파일을 만들고 다음 값을 설정하세요.

```env
VITE_API_BASE_URL=http://localhost:8000
VITE_WS_BASE_URL=ws://localhost:8000
```

환경 변수를 변경한 뒤에는 개발 서버를 다시 시작해야 합니다.

## 백엔드 연동 범위

프런트엔드는 다음과 같은 백엔드 기능을 사용합니다.

- `POST /auth/signup`, `POST /auth/login`: 회원가입 및 로그인
- `GET /auth/user-count`: 사용자 수 조회
- `POST /api/v1/sessions`: 발표 세션 생성
- `POST /api/v1/sessions/:id/start`, `end`, `cancel`: 세션 상태 제어
- `GET /api/v1/sessions/:id/report`: 분석 리포트 조회
- `GET /api/v1/users/me/sessions`: 개인 세션 이력 조회
- `ws://<host>/ws/sessions/:id`: 발표 중 청중 반응, 질문, 피드백을 위한 실시간 통신

> 이 저장소에는 현재 프런트엔드 코드가 포함되어 있습니다. 완전한 발표 세션, 인증, AI 분석 기능을 사용하려면 위 API 규약을 구현한 백엔드를 함께 실행해야 합니다.

## 사용 방법

1. 홈 화면에서 발표 환경을 선택하거나 **시작하기**를 누릅니다.
2. 로그인 후 발표 유형, 청중, 인원, 압박 강도, 발표 시간, 질문 허용 여부를 설정합니다.
3. 마이크 권한을 허용하고 발표를 시작합니다.
4. 실시간 지표와 AI 청중의 질문·반응을 보며 발표와 답변을 진행합니다.
5. 종료 후 리포트에서 발표 데이터를 확인하고, 히스토리에서 다음 연습의 목표를 세웁니다.

## 스크립트

`frontend` 디렉터리에서 실행합니다.

| 명령어 | 설명 |
| --- | --- |
| `npm run dev` | 개발 서버 실행 |
| `npm run build` | 프로덕션 빌드 생성 |
| `npm run preview` | 빌드 결과 미리 보기 |
| `npm run lint` | ESLint 검사 |

## 브라우저 참고 사항

- 음성 인식은 브라우저 지원 여부와 마이크 권한에 영향을 받습니다.
- HTTPS 또는 `localhost` 환경에서 마이크 접근이 가장 안정적입니다.
- 음성 인식을 지원하지 않는 환경에서는 시뮬레이션의 데모 흐름이 사용될 수 있습니다.
