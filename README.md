# matrix_support_script

run as
./check_srv.sh HS_domain_name PORT

example
./check_srv.sh matrix.org 8448

This script retrieves the SRV record for matrix.org and the supplied HomeServer Domain Name
then presents a table for review.
It also compares the port number you supply with the port returned in the SRV record.
If they are different an ERROR is printed.

The SRV record for matrix.org is shown in the table to be used as a visual comparison.
