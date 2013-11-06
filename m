From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 06 Nov 2013 16:14:40 +0000
Subject: re: sh: add clk_round_parent() to optimize parent clock rate
Message-Id: <20131106161440.GF15603@elgon.mountain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Guennadi Liakhovetski,

This is a semi-automatic email about new static checker warnings.

The patch 6af26c6c99f0: "sh: add clk_round_parent() to optimize 
parent clock rate" from Nov 2, 2010, leads to the following Smatch 
complaint:

drivers/sh/clk/core.c:641 clk_round_parent()
	 error: we previously assumed 'best_freq' could be null (see line 630)

drivers/sh/clk/core.c
   629				best = freq;
   630				if (best_freq)
   631					*best_freq = freq_high;
   632			}
   633	
   634			if (target - freq_low < error) {
   635				error = target - freq_low;
   636				best = freq;
   637				if (best_freq)
                                    ^^^^^^^^^
Check.

   638					*best_freq = freq_low;
   639			}
   640	
   641			pr_debug("%u / %lu = %lu, / %lu = %lu, best %lu, parent %u\n",
   642				 freq->frequency, div, freq_high, div + 1, freq_low,
   643				 *best_freq, best->frequency);
                                 ^^^^^^^^^^
Unchecked dereference.

regards,
dan carpenter
