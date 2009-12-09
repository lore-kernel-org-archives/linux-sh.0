From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 09 Dec 2009 03:44:54 +0000
Subject: Re: [PATCH] arch/sh: Replace an explicit computation by the use of the container_of macro
Message-Id: <20091209034453.GB28280@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <200912071046.27330.npalix@diku.dk>
In-Reply-To: <200912071046.27330.npalix@diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Palix <npalix@diku.dk>
Cc: kernel-janitors@vger.kernel.org, Stuart Menefy <stuart.menefy@st.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Dec 07, 2009 at 10:46:26AM +0100, Nicolas Palix wrote:
> From 945e75c0e3202ab4cd0b8f185ea4be5609806edb Mon Sep 17 00:00:00 2001
> From: Nicolas Palix <npalix@diku.dk>
> Date: Mon, 7 Dec 2009 10:38:55 +0100
> 
> The macro container_of from kernel.h performs the same
> pointer arithmetic operation.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> type T;
> expression mptr;
> expression member;
> @@
> 
> - (void *)((char *)mptr - offsetof(T, member))
> + container_of(mptr, T, member)
> // </smpl>
> 
> Signed-off-by: Nicolas Palix <npalix@diku.dk>

Applied, thanks.
