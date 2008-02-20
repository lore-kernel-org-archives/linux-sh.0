From: Stuart MENEFY <stuart.menefy@st.com>
Date: Wed, 20 Feb 2008 12:15:52 +0000
Subject: Re: [PATCH] sh: fix readsl/writesl argument
Message-Id: <47BC19F8.4030007@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080220102853.22714.57848.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080220102853.22714.57848.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Magnus

Magnus Damm wrote:
> writesl() and readsl() use void __iomem * as argument but the current sh 
> version of __raw_writesl()/__rawreadsl() takes unsigned long. Casting the
> pointer fixes smc91x warnings.
...
> --- 0001/include/asm-sh/io.h
> +++ work/include/asm-sh/io.h	2008-02-20 16:34:28.000000000 +0900
> -#define writesl __raw_writesl
> -#define readsl  __raw_readsl
> +#define writesl(m, a, c) __raw_writesl((unsigned long)(m), (a), (c))
> +#define readsl(m, a, c)  __raw_readsl((unsigned long)(m), (a), (c))

Wouldn't it be better to do this as inline functions, that way we don't
loose the type checking?

Stuart
