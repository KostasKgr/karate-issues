@ignore
Feature:
  Scenario: Prepare data via complex processing and api calls

    * def xml =
    """
        <root>
            <hello>
                <there>everyone</there>
            </hello>
            <hello>
                <there>anyone</there>
            </hello>
        </root>
    """

    # if this definition is removed, then the data_use.feature does not hang, try commenting it out.
    # Even though it is not used anywhere in that feature
    * def nodes = get xml //hello

    * def data = [{name: "A", stats: {"vitality":2}}, {name: "B", stats: {"strength":3}}, {name: "C", stats: {"intelligence":5}}]
