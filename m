From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 01 Nov 2012 00:08:41 +0000
Subject: Re: [PATCH 1/3] sh: clkfwk: add sh_clk_fsidiv_register()
Message-Id: <20121101000841.GA24257@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 30, 2012 at 08:06:55PM -0700, Kuninori Morimoto wrote:
> This patch adds sh_clk_fsidiv_register() to share FSI-DIV clock code
> 
This looks ok, but I don't know why you are using the __raw_xxx I/O
accessors when it's clear the rest of the clock framework is using
ioread/writeX. Please fix this up.
