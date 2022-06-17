---
title: "Continuous-Integration with Github: Unit Tests with Pytest"
subtitle: "Motivated by and largely based on \"Introduction to automated testing\" by Nils Meyer"
author: Julian Karl Bauer
date: 22.06.2022

documentclass: latexRessources/sdqbeamer
# theme: "Szeged"
# pandoc -t beamer --pdf-engine=xelatex --highlight-style=kate slides.md -o slides.pdf

# mainfont: DejaVuSerif.ttf
# sansfont: DejaVuSans.ttf
monofont: DejaVuSansMono.ttf
mathfont: texgyredejavu-math.otf

# Aspect ratio is defined in sdqbeamer.cls line 77
classoption: "aspectratio=169"
urlcolor: brown
---

# Live Coding and Code of Conduct

We will solve exercises together by simultaneous live-coding.  
You will see my screen and you are encouraged to follow the steps on your local machine.

**Code of Conduct** following the [Software Carpentries][url_the_software_carpentries]

- "Use welcoming and inclusive language
- Be respectful of different viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community
- Show courtesy and respect towards other community members"[^notecarpentriescodeofconduct]

[^notecarpentriescodeofconduct]: <https://docs.carpentries.org/topic_folders/policies/code-of-conduct.html>

# Cooperative Markdown Document

Please find a shared document at [https://hackmd.io/V32-TzF_TzCOM9IXTvP4IA](https://hackmd.io/V32-TzF_TzCOM9IXTvP4IA)  
and feel free to contribute with annotations, questions or notes.

$\quad\quad\quad\quad$  ![][fig_hackmd]

[fig_hackmd]: images/hackmd.png { width=8cm }


# Motivation

![Avoid breaking things (© Nils Meyer)][fig_motivation_changes_nm]



# Unit Tests
::: columns

:::: {.column width=1.0}
**Unit tests** are code snippets which *test* small *units* of our code.

&nbsp;

Why do we need it?

- To ensure that all parts of our code run as expected
- To ensure that changes do not break old functionality

&nbsp;

When do we need it?

- Refactoring code
- Working with multiple contributors / authors
- Deployment for end users which do random stuff
- Always - at least, if we are interested in successful long-term projects -

::::

:::


# More on Tests

A test is a procedure which prepares and performs a comparison.

&nbsp;

A comparison

- is done between calculated values and (known) expectation,
- yields a boolean result,
- requires specification of a tolerance if non-integer entities are compared.

&nbsp;

Any conditional expression which evaluates to

- `True` if something works as expected and
- `False` otherwise, can be turned into a test.



# Pytest: Unit Tests in Python
::: columns

:::: {.column width=0.6}
[**Pytest**][url_pytest] is

- a Python package
- a command line tool
- "a framework" ... "which can scale to support complex functional testing for applications and libraries"[^notepytest]

[^notepytest]: <https://docs.pytest.org/en/latest/>


&nbsp;

Why do we need it?

- It simplifies
    - writing,
    - collecting,
    - executing and
    - reporting on tests

::::

:::: {.column width=0.3}

How do we get it?

- `pip install pytest`
- `conda install -c anaconda pytest`

&nbsp;

![][fig_pytest_logo]

::::

:::

# Exercise 0: Sign in to [GitHub][url_github]

- If you already have a Github account, please log in.
- If you do not have a Github account yet, please get yourself one by signing up

$\quad\quad\quad\quad$  ![][fig_github_login]



[url_github]: https://github.com/
[fig_github_login]: images/github_login.png { width=8cm }


# Exercise 1: Create a New Git Repository

::: columns

:::: {.column width=0.4}
On [Github][url_github], create a new repository with

- Repository name: workshop_ci_pytest
- - [x] Public
- - [x] Add a README file
- .gitignore: Python
- License: None

::::

:::: {.column width=0.5}

![][fig_new_repo]

::::

:::

[fig_new_repo]: images/new_repo.png { width=8cm }


# Exercise 2: (Optional) Clone Repository, Install pytest

::: columns

:::: {.column width=0.6}

If you would like to use Pytest on your local machine, please

- Install [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- Clone your repo
    - In your repo on Github, click `Clone`, `HTTPS` and copy the URL (see screenshot)
    - Navigate to your preferred location on your hard disk and open a terminal
    - Type `git clone <your-HTTPS-URL>` with <your-HTTPS-URL> replaced by your URL
- Install Python, e.g., using [Anaconda](https://www.anaconda.com/products/distribution) or [Miniconda](https://docs.conda.io/en/latest/miniconda.html)
- Consider creating a [virtual environment][url_conda_env_manager]
- Install pytest using either `pip` or `conda`
    - `pip install pytest`
    - `conda install -c anaconda pytest`

::::

:::: {.column width=0.3}

![Get HTTPS address][fig_github_clone]

::::

:::

[fig_github_clone]: images/github_clone.png { width=5cm }
[url_conda_env_manager]: https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html



# Exercise 3: Define a Simple Python Function

::: columns

:::: {.column width=0.45}
```
workshop_ci_pytest
│   README.md
│   functions.py
```
::::

:::: {.column width=0.45}
### `functions.py`

```python
def add(x, y):
    return x + y
```

::::

:::


# Exercise 4: Write a Test for `functions.add()`

::: columns

:::: {.column width=0.45}
```
workshop_ci_pytest
│   README.md
│   functions.py
└───test
│    │   test_functions.py
```
::::

:::: {.column width=0.45}
### `test_functions.py`

```python
from functions import add

def test_add():
    assert add(3,4) == 7
```

::::

:::

&nbsp;

and (**optional**) run this test with pytest on your local machine

```
python -m pytest
```





# Tests in the Python Project Structure

::: columns

:::: {.column width=0.55}

- The Python project structure contains a directory named `test`.
- Inside this `test` directory, (unit) tests can be structured in files, classes and functions.
- Files, classes and functions which contain tests have to follow a naming convention and start with the prefix `test`.
- Helper functions and [fixtures][url_pytest_fixtures] can be used to parameterize tests and keep the
test code dry.

&nbsp;

- [Do][url_unit_tests_throw_away] / [Don't][url_unit_tests_that_last] throw away tests
 ([discussion][url_unit_tests_discussion])
- [Test-driven development][url_test_driven_dev]

::::

:::: {.column width=0.35}
```
project_name
│   README.md
│   setup.py
│
└───package_name
│    │   __init__.py
│    │   module_name_1.py
│    │   module_name_2.py
|
└───test
│    │   test_module_name_1.py
│    │   test_module_name_2.py
```
::::

:::

# Running Pytest

- [Pytest][url_pytest] can be executed from the command line either
  - as a command by **pytest**
  - or as a Python package by **python -m pytest**

&nbsp;

- Execution as a Python package
  adds the current working directory of the terminal
  to the Python path which is used during the pytest run.
  In consequence, import-precedence
  leads to an import of the local source code, if present.

&nbsp;

- Within a Python project structure, run tests
  - against an installed package with **pytest** (recommended) or
  - against local files with **python -m pytest**.


# Automate Tests

![© Nils Meyer][fig_motivation_changes_nm]


# Continuous Integration [(CI)][url_ci]

Automating the integration of code changes from multiple contributors into a single software project.

- Avoid broken code
- Avoid annoying repetitive manual tasks
- Document settings
- Act as a kind of [hallway test][url_hallwaytest]...
if you tell CI what to do,
you can also instruct a skilled user and your future-self.

&nbsp;

**Git-based Options**

::: columns

:::: {.column width=0.45}

[Github Actions][url_github_actions]

- Batteries included
- Free version: 2000 free CI-minutes/month


::::

:::: {.column width=0.45}
[Gitlab-CI][url_gitlab_ci]

- [KIT-Gitlab][url_gitlab_kit] requires registration as employee or student
- No Batteries (Users have to install [Gitlab-runner][url_gitlab_runner])

::::

:::


[url_hallwaytest]: https://www.techopedia.com/definition/30678/hallway-usability-testing
[url_ci]: https://en.wikipedia.org/wiki/Continuous_integration
[url_github_actions]: https://docs.github.com/en/actions
[url_gitlab_ci]: https://docs.gitlab.com/ee/ci/
[url_gitlab_kit]: https://git.scc.kit.edu/users/sign_in

[url_gitlab_runner]: https://docs.gitlab.com/runner/


# Exercise 5: Hello World in Github Actions

Print "Hello World" to the Github actions terminal.

Therefore, create a Github action workflow named "Hello World"
which contains a job called "Print_Hello_World"
echoing "Hello World".

::: columns

:::: {.column width=0.27}
```
workshop_ci_pytest
└───.github
|   └───workflows
|       | hello_world.yml
|
│   README.md
| ...
```
::::

:::: {.column width=0.35}
### `hello_world.yml`

```yaml
name: Hello World
on: [push]
jobs:
  Print_Hello_World:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Hello World"

```

::::

:::: {.column width=0.27}

![][fig_hello_world_output]

::::

:::

[fig_hello_world_output]: images/hello_world_output.png { width=4cm }


# Exercise 6: Inspect Executed Github Actions

![][fig_github_actions_overview]

[fig_github_actions_overview]: images/github_actions_overview.png { width=10cm }


# Exercise 7: Run Pytest in Github Actions

Create a workflow which runs `pytest` against the current repository state.

::: columns

:::: {.column width=0.3}
```
workshop_ci_pytest
└───.github
|   └───workflows
|       | hello_world.yml
|       | pytest.yml
|
│   README.md
| ...
```
::::

:::: {.column width=0.6}
### `pytest.yml`

```yaml
name: Unit Tests
on: [push]
jobs:
  Clone:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3 # Make repo available
      - name: Install pytest
        run: pip install pytest
      - name: Execute pytest as module
        run: python -m pytest -vv
```

::::

:::



# Thank You for Your Attention
![fig_Thank_You] \



[fig_Thank_You]: latexRessources/thank_you_slide.png
[fig_motivation_changes_nm]: images/motivation_changes_nm.png { width=14cm }
[fig_pytest_logo]: images/pytest.png { width=4cm }


[url_the_software_carpentries]: https://software-carpentry.org/
[url_pytest]: https://docs.pytest.org/en/latest/
[url_pytest_fixtures]: https://docs.pytest.org/en/6.2.x/fixture.html
[url_unit_tests_that_last]: https://osherove.com/blog/2007/9/13/throw-away-tests-vs-tests-that-last.html
[url_unit_tests_throw_away]: https://medium.com/ngconf/you-should-throw-away-your-unit-tests-717c6884a77b
[url_unit_tests_discussion]: https://softwareengineering.stackexchange.com/questions/147055/when-is-unit-testing-inappropriate-or-unnecessary/147075
[url_test_driven_dev]: https://en.wikipedia.org/wiki/Test-driven_development




