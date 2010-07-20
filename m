From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Jul 2010 06:07:20 +0000
Subject: [Report] Current genesis tree say "Division by zero in kernel"
Message-Id: <w3pfwzeelev.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear all

Current Paul's genesis tree say

---------------------
(snip)
 sh_cmt.10: using deprecated clock lookup                                       
 sh_cmt.10: used for clock events                                               
 sh_cmt.10: used for periodic clock events                                      
Division by zero in kernel.                                                     
[<c0027f30>] (unwind_backtrace+0x0/0xe4) from [<c013fd7c>] (Ldiv0+0x8/0x10)     
 sh_cmt.10: used as clock source                                                
(snip)
---------------------

I'm not sure why.
But kernel seems works well.

Best regards
--
Kuninori Morimoto
 
