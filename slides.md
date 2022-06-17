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

**Code of Conduct** following the [Software Carpentries][url_thesoftwarecarpentries]

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

::: columns

:::: {.column width=0.45}
```
python -m pytest
```
::::

:::: {.column width=0.45}


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






# Tests in Python

::: columns

:::: {.column width=0.5}

- In Python, a test is a piece of code (usually a function)
which asserts that something is true.
- A test usually ends with the pattern  
`assert result`  
where the `assert`-statement
   - does nothing if `result is True` and
   - raises an exception of type `AssertionError` otherwise.

::::

:::: {.column width=0.5}
```python
def test_case_xy_func_foobaa():
    value = ...
    assert comparison(value, expectation)
```
::::

:::

# Tests in Python

::: columns

:::: {.column width=0.55}

- The Python project structure contains a directory named `test`.
- Inside this `test` directory, (unit) tests can be structured in files, classes and functions.
- Files, classes and functions which contain tests have to follow a naming convention and start with the prefix `test`.
- Helper functions and [fixtures][pytestfixtures] can be used to parameterize tests and keep the
test code dry.

&nbsp;

- [Do][unittests_throwaway] / [Don't][unittests_tests_that_last] throw away tests
 ([discussion][unittests_discussion])
- [Test-driven development][urltestdrivendev]

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

# Test Runner: [pytest][pytest]

- A test runner
  - inspects the project and collects tests
  - executes the collected tests
  - summarizes the test results
- [Pytest][pytest] is a convenient choice for small projects.

&nbsp;

- [Pytest][pytest] can be executed from the command line either
  - as a command by `pytest`
  - or as a Python package by `python -m pytest`
- Execution as a Python package
  adds the current working directory of the terminal
  to the Python path which is used during the pytest run.
  In consequence, import-precedence
  leads to an import of the local source code, if present.
- Run tests
  - against an installed package with `pytest`
  - against local files with `python -m pytest`

<!-- either with or without
adding the current directory to the Python path which is used during the pytest run.
- If the current directory is added to the Python path, import-precedence
leads to an import of the local source code, if present in the current directory.
This can be done by  
`python -m pytest`
- If pytest is executed by  
`pytest`  
the package which should be tested has to be installed in the current environment and
the tests then run against the installed package. -->

# Exercise 4: Write and Execute a Test

- Write a unit test which tests whether `KGbyEv(E=10,v=0)` yields $K=10/3$ and $G=10/2$.
- Execute the test against the local source code files.
- Identify required packages.

# Solution 4: Write and Execute a Test

::: columns

:::: {.column width=0.25}
```
cooperative_python_coding
│   README.md
│   s001_get_KG.py
│   
└───toy_package
│    │   __init__.py
│    │   material.py
│   
└───test
│    │   test_material.py
```
::::

:::: {.column width=0.45}
### [`test_material.py`](https://git.scc.kit.edu/IRTG2078/workshop_thomashof_2021/cpc_jb_template/-/blob/main/test/test_material.py)

```python
import toy_package
import numpy as np

def test_KGbyEv_single_values():
    young = 10

    func = toy_package.material.KGbyEV

    assert np.allclose(
        func(E=young, v=0.0),
        (young / 3., young / 2.),
        )

```
::::

:::: {.column width=0.22}
### Install pytest
```
conda install pytest
```

### Run pytest
```
python -m pytest
```

::::

:::

# Continuous Integration [(CI)][urlci]
- CI helps to
   - document settings and
   - automate repetitive tasks (e.g. running tests),
    which might be skipped otherwise.
- CI acts as a kind of [hallway test][hallwaytest]...   
if you tell CI what to do,
you can also instruct a skilled user and your future-self.

&nbsp;

[Gitlab-CI][urlgitlabci]

- Specify todos in `.gitlab-ci.yml`
  - [Example gallery][gitlabciexamples]
- Enable a [Gitlab-runner][gitlabrunner]
- Output can be stored as [artefact][gitlabartefacts] and accessed by URL


# Exercise 5: Run Pytest with Gitlab-CI
- Create `.gitlab-ci.yml`
- Add simple test stage
- Push to remote
- Check if group runner is enabled
- Watch pipeline execution

# Solution 5: Run Pytest with Gitlab-CI

::: columns

:::: {.column width=0.4}
### .gitlab-ci.yml
```yml
stages:
  - test

test_3.9:
    stage: test
    image: "python:3.9"
    script:
        - python setup.py install
        - pip install pytest
        - pytest --verbose
```
::::

:::: {.column width=0.4}
![Gitlab-CI: Passing tests][gitlabcipython]

::::

:::

# Beautifier: Black

- [Black][black] your code
  - Improve readability
  - Avoid discussion on style
  - Avoid misleading blame results
    - If someone formats your code contribution,  
    changes are high that a third person thinks the
    formatter wrote the code.

::: columns

:::: {.column width=0.45}
### Original
```python
from toy_package.material import KGbyEV
compr,shear =   KGbyEV(E = 10, v=0.3,)

print('K=', compr)
print('G=',shear)
```
::::

:::: {.column width=0.45}
### Blacked
```python
from toy_package.material import KGbyEV

compr, shear = KGbyEV(
    E=10,
    v=0.3,
)

print("K=", compr)
print("G=", shear)
```
::::

:::


# Exercise 6: Black your Project
- Commit your current project state
- Install black  
- Black a singel file
- Black the complete directory
- Search for a plug-in for your editor
   - [Atom][urlatomblack]
- Think about [pre-commit][urlprecommit]

# Solution 6: Black your Project

::: columns

:::: {.column width=0.45}

### Save

```
git add *
git commit -m 'save current state'
```

### Install

```
pip install black
```

::::

:::: {.column width=0.45}

### Single file

```
black s001_get_KG.py
git diff s001_get_KG.py
```

### Directory

```15
black .
git diff .
```

::::

:::


<!-- # Formatting Tools and Checks
- [Black][black]
- [pre-commit][precommit] -->

# Thank You for Your Attention
![figThankYou] \



[figThankYou]: latexRessources/thank_you_slide.png
[fig_motivation_changes_nm]: images/motivation_changes_nm.png { width=14cm }
[fig_pytest_logo]: images/pytest.png { width=4cm }




[url_thesoftwarecarpentries]: https://software-carpentry.org/
[url_pytest]: https://docs.pytest.org/en/latest/







[figEnvironments]: images/environments.png { width=7cm }
[figEnvironmentsSmaller]: images/environments.png { width=5cm }
[gitlabcipython]: images/gitlabcipython.png { width=7cm }

[figccookie_in]: images/cookie_in.png { height=5.5cm }
[figccookie_out]: images/cookie_out.png { height=5.5cm }

[condacheatsheet]: https://docs.conda.io/projects/conda/en/latest/_downloads/843d9e0198f2a193a3484886fa28163c/conda-cheatsheet.pdf
[pytest]: https://docs.pytest.org/en/6.2.x/
[pytestfixtures]: https://docs.pytest.org/en/6.2.x/fixture.html
[unittests_tests_that_last]: https://osherove.com/blog/2007/9/13/throw-away-tests-vs-tests-that-last.html
[unittests_throwaway]: https://medium.com/ngconf/you-should-throw-away-your-unit-tests-717c6884a77b
[unittests_discussion]: https://softwareengineering.stackexchange.com/questions/147055/when-is-unit-testing-inappropriate-or-unnecessary/147075
[hallwaytest]: https://www.techopedia.com/definition/30678/hallway-usability-testing
[black]: https://github.com/psf/black
[urlprecommit]: https://pre-commit.com/
[gitlabciexamples]: https://docs.gitlab.com/ee/ci/examples/index.html
[gitlabrunner]: https://docs.gitlab.com/runner/
[gitlabartefacts]: https://docs.gitlab.com/ee/ci/pipelines/job_artifacts.html
[urlvenv]: https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/#creating-a-virtual-environment
[urlvenvpython]: https://docs.python.org/3/tutorial/venv.html
[urlcondamanager]: https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html
[urlpipenv]: https://pypi.org/project/pipenv/
[urldry]: https://de.wikipedia.org/wiki/Don%E2%80%99t_repeat_yourself
[urlcleancode]: https://de.wikipedia.org/wiki/Clean_Code
[urltestdrivendev]: https://en.wikipedia.org/wiki/Test-driven_development

[urlimports1]: https://docs.python.org/3/reference/import.html
[urlimports2]: https://realpython.com/python-import/
[urlci]: https://en.wikipedia.org/wiki/Continuous_integration
[urlgitlabci]: https://docs.gitlab.com/ee/ci/

[urlcookiecutter]: https://github.com/cookiecutter/cookiecutter
[urlcookiecutterpypackage]: https://github.com/audreyfeldroy/cookiecutter-pypackage

[urlatomblack]: https://atom.io/packages/atom-black

[urlnumpy]: https://github.com/numpy/numpy
[urlscipy]: https://github.com/scipy/scipy
[urlsympy]: https://github.com/sympy/sympy
[urlfiberoripy]: https://github.com/nilsmeyerkit/fiberoripy
[urlmechkit]: https://github.com/JulianKarlBauer/mechkit

[urlscikitlearn]: https://github.com/scikit-learn/scikit-learn/tree/main
[urlastropy]: https://github.com/astropy/astropy/tree/main

[urlmetaresearch]: https://github.com/orgs/facebookresearch/repositories

[urlmeshio]: https://github.com/nschloe/meshio/
[urlmeshzoo]: https://github.com/nschloe/meshzoo

[urlfairdfg]: https://www.dfg.de/download/pdf/foerderung/rechtliche_rahmenbedingungen/gute_wissenschaftliche_praxis/kodex_gwp_en.pdf
[urlfairdatazenodo]:https://about.zenodo.org/principles/
[urlfairsoftwarecern]: https://indico.cern.ch/event/588219/contributions/2384979/attachments/1426152/2189855/FAIR_Software_Principles_CERN_March_2017.pdf
[urlpythonpackages]: https://packaging.python.org/tutorials/packaging-projects/
[urlpythonpackagehitchiker]: https://docs.python-guide.org/writing/structure/
