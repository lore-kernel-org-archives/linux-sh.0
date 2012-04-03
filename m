From: Hideo Saito <saito@densan.co.jp>
Date: Tue, 03 Apr 2012 04:48:58 +0000
Subject: gcc optimization problem on const variable
Message-Id: <20120403.134858.179772577.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Dear all.

Following definition of the variable seems to cause an unexpected result by gcc optimization on gcc-4.4.5, that is the optimizer considers sh_io_port_base is equal to '-1'. I think that following change maybe fixes this problem.

 const unsigned long sh_io_port_base __read_mostly = -1;


--- arch/sh/kernel/ioport.c.org	2012-01-05 08:55:44.000000000 +0900
+++ arch/sh/kernel/ioport.c	2012-04-02 15:20:31.000000000 +0900
@@ -14,17 +14,17 @@
 const unsigned long sh_io_port_base __read_mostly = -1;
 EXPORT_SYMBOL(sh_io_port_base);
 
 void __iomem *__ioport_map(unsigned long addr, unsigned int size)
 {
 	if (sh_mv.mv_ioport_map)
 		return sh_mv.mv_ioport_map(addr, size);
 
-	return (void __iomem *)(addr + sh_io_port_base);
+	return (void __iomem *)(addr + *(volatile unsigned long *)&sh_io_port_base);
 }
 EXPORT_SYMBOL(__ioport_map);
 
 void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
 	void __iomem *ret;
 
 	ret = __ioport_map_trapped(port, nr);
