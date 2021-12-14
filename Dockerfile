FROM postgres:14

MAINTAINER Jan Dedek <jan.dedek@datlowe.cz>

RUN apt-get update && apt-get install -y curl

RUN mkdir /tmp/fulltext_dicts \
  && curl -L http://postgresql.ok.cz/download/tsearch2cz.tar.gz \
     | tar -xzC /tmp/fulltext_dicts \
#  && mv /tmp/fulltext_dicts/czech.* /usr/share/postgresql/$PG_MAJOR/tsearch_data/ \
  && iconv --from-code=ISO88592 --to-code=UTF-8 /tmp/fulltext_dicts/czech.dict -o /usr/share/postgresql/$PG_MAJOR/tsearch_data/czech.dict \
  && iconv --from-code=ISO88592 --to-code=UTF-8 /tmp/fulltext_dicts/czech.aff -o /usr/share/postgresql/$PG_MAJOR/tsearch_data/czech.affix \
  && iconv --from-code=ISO88592 --to-code=UTF-8 /tmp/fulltext_dicts/czech.stop -o /usr/share/postgresql/$PG_MAJOR/tsearch_data/czech.stop \
  && rm -rf /tmp/fulltext_dicts/ 

ADD czech.stop /usr/share/postgresql/$PG_MAJOR/tsearch_data/

#snowball
ADD dict_snowball.so /usr/lib/postgresql/$PG_MAJOR/lib/

ADD add-tsearch-czech.sh docker-entrypoint-initdb.d/


#RUM
ADD RUM_1.3/lib/ /usr/lib/postgresql/$PG_MAJOR/lib/

ADD RUM_1.3/extension/ /usr/share/postgresql/$PG_MAJOR/extension
