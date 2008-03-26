From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 26 Mar 2008 09:22:27 +0000
Subject: Re: [PATCH] SuperH floppy: kill 'register' keyword from floppy.h header
Message-Id: <20080326092227.GB7867@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.LNX.1.00.0803260213550.1901@dragon.funnycrock.com>
In-Reply-To: <alpine.LNX.1.00.0803260213550.1901@dragon.funnycrock.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Ian Molton <spyro@f2s.com>, Alain L Knaff <Alain.Knaff@lll.lu>, David C Niemi <niemi@tux.org>, Trivial Patch Monkey <trivial@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Mar 26, 2008 at 02:16:32AM +0100, Jesper Juhl wrote:
> 
> When compilers became generally better at optimizing code than humans, the
> register keyword became mostly useless. For the floppy driver it certainly
> is since it's so slow compared to the rest of the system that optimizing
> access to a single variable or two isn't going to make any real
> difference
> So let's just leave it to the compiler - it'll do a better job anyway.
> 
> This patch does away with a few register keywords in the SuperH floppy
> driver.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

applied, thanks.
