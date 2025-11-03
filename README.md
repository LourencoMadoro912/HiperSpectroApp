#  Hiper Spectro — Simulador Didático de Absorbância

Um aplicativo Flutter educacional que **simula o funcionamento de um espectrofotômetro**, ajudando alunos e professores a compreenderem a relação entre **tempo**, **temperatura** e **níveis de absorbância** com feedback visual em **gráficos e cores**.

---

##  Objetivo

O **Hiper Spectro** permite explorar de forma interativa como a absorbância varia com o tempo e temperatura em experimentos reais (como o escurecimento enzimático da maçã).  
O aplicativo fornece:

- Visualização gráfica (*Absorbância × Tempo*);
- Alteração dinâmica de dados conforme a **temperatura** inserida;
- Simulação visual por **mudança de cor da amostra**;
- Baseado em dados experimentais reais (armazenáveis no Firebase);
- Interface intuitiva e moderna para uso em **aulas de laboratório**.

---

##  Funcionalidades Principais

| Funcionalidade | Descrição |
|----------------|------------|
| **Gráfico Interativo** | Mostra Absorbância (Y) vs Tempo (X) usando a biblioteca `fl_chart`. |
| **Entrada de Temperatura** | O usuário define a temperatura (5°C, 25°C, 30°C, 40°C ou personalizada). |
| **Simulação por Cor** | A cor da amostra muda conforme o valor médio de absorbância. |
| **Resumo da Simulação** | Exibe temperatura, absorbância média e tempo total. |
| **Dados Reais ou Simulados** | Busca dados do Firebase Firestore; se não houver, gera dados simulados. |

---

## Arquitetura MVVM

O projeto segue a arquitetura **Model–View–ViewModel (MVVM)**:

