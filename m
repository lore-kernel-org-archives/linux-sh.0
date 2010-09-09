From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 09 Sep 2010 09:53:47 +0000
Subject: Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c
Message-Id: <20100909095347.GA9112@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 15:39 Thu 02 Sep     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> factorise some generic infrastructure to assist looking up struct clks
> for the ARM & SH architecture.
> 
> as the code is identical at 99%
> 
> put the arch specific code for allocation as example in asm/clkdev.h
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
is it ok?

Best Regards,
J.
