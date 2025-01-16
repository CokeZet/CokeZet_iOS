# 프로젝트 컴파일 시 주의사항

Tuist가 적용된 프로젝트입니다.  
따라서 아래의 과정을 반드시 거쳐야 정상적으로 컴파일이 가능합니다.

### 0. Terminal을 킨다.
### 1. Project Root Location으로 이동한다.
### 2. `tuist install`을 진행한다.
### 3. `tuist generate`를 진행한다.
### 4. Root Location에 있는 **CokeZet-iOS_Workspace**를 실행한다.
### 5. 컴파일 진행.

---

# 새로운 Feature를 만들 때 주의사항

아래의 과정을 거쳐서 Feature를 생성하거나, Scaffold를 추가해주세요.

### 0. Terminal을 킨다.
### 1. Project Root Location으로 이동한다.
### 2. `tuist scaffold list`를 확인한다.
### 3. 아래 명령어를 입력하여 새로운 Feature를 생성한다.
```
tuist scaffold Feature --name "Feature 이름"
```
#### 예시:
```
tuist scaffold Feature --name Test
```
### 4. 생성된 Feature에 작업을 실행한다.

---

# 새로운 DemoApp을 만들 때 주의사항

아래의 과정을 거쳐서 DemoApp을 생성하거나, Scaffold를 추가해주세요.

### 0. Terminal을 킨다.
### 1. Project Root Location으로 이동한다.
### 2. `tuist scaffold list`를 확인한다.
### 3. 아래 명령어를 입력하여 새로운 DemoApp을 생성한다.
```bash
tuist scaffold Feature --name "Demo App 이름" --features "Feature 이름"
```
#### 예시:
```bash
tuist scaffold Feature --name Test --features Test
```
### 4. 생성된 DemoApp에 작업을 실행한다.

---

### 참고
- `tuist scaffold list` 명령어를 통해 사용 가능한 Scaffold 템플릿 목록을 확인할 수 있습니다.

--- 
