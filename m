From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 05 Jan 2011 07:57:38 +0000
Subject: Re: [PATCH] sh: correct definitions to access stack pointers
Message-Id: <20110105075737.GB23889@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4D1F7434.4090108@gmail.com>
In-Reply-To: <4D1F7434.4090108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: roel kluin <roel.kluin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org

On Sat, Jan 01, 2011 at 07:36:36PM +0100, roel kluin wrote:
> A definition like:
> 
> #define regs_return_value(regs)	((regs)->regs[0])
> 
> called with regs_return_value(foo) will be preprocessed to:
> 
> ((foo)->foo[0])
>         ^^^
> So to fix this to ensure the preprocessor compiles such calls correctly.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Applied, thanks.
