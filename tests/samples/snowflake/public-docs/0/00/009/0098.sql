SELECT * FROM invoices
  WHERE invoice_date < '2018-01-01';

SELECT * FROM invoices
  WHERE invoice_date < '2018-01-01'
    AND paid = FALSE;