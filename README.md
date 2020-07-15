Expected to have the following settings in vs code:

```
    "karateRunner.karateRunner.promptToSpecify": false,
    "karateRunner.buildReports.toTarget": "**/{cucumber-html-reports/overview-features,surefire-reports/timeline,surefire-reports/karate-summary,surefire-reports/src.test.java}*",
    "karateRunner.tests.activityBarDisplayType": "Deep",
    "karateRunner.karateJar.commandLineArgs": "",
    "karateRunner.karateCli.overrideKarateRunner": true,
    "karateRunner.karateCli.commandLineArgs": "-t ~@ignore"
```

If not running in override runner mode then this might work as well:

```
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>${maven.surefire.version}</version>
    <configuration>
        <systemProperties>
            <karate.options>--tags ~@ignore</karate.options>
        </systemProperties>            
    </configuration>
</plugin>
```