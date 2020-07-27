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

    # if this definition is in place removed, then
    #  * If the feature data_use feature is run from intellij, it hangs forever
    #  * If run throught he ExampplesRunner then the following is reported:
    #       java.lang.IllegalAccessError: class com.sun.org.apache.xerces.internal.dom.DocumentImplAccAccess tried to access protected field com.sun.org.apache.xerces.internal.dom.ParentNode.firstChild (com.sun.org.apache.xerces.internal.dom.DocumentImplAccAccess is in unnamed module of loader net.minidev.asm.DynamicClassLoader @389adf1d; com.sun.org.apache.xerces.internal.dom.ParentNode is in module java.xml of loader 'bootstrap')
    # Even though it is not used anywhere in that feature
    # If this def is uncommented, then everything works
    # Assume that this def is useful for the computation though..
    * def nodes = get xml //hello

    * def data = [{name: "A", stats: {"vitality":2}}, {name: "B", stats: {"strength":3}}, {name: "C", stats: {"intelligence":5}}]
