From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 25 Apr 2008 09:02:07 +0000
Subject: Re: [RFC patch 8/9] SH remove -traditional
Message-Id: <20080425090207.GB30569@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080422172404.502954084@polymtl.ca> <20080422172843.205481136@polymtl.ca>
In-Reply-To: <20080422172843.205481136@polymtl.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Sam Ravnborg <sam@ravnborg.org>, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Apr 22, 2008 at 01:24:12PM -0400, Mathieu Desnoyers wrote:
> Subject: [RFC patch 8/9] Re: [PATCH] Stringify support commas
>  > This is a no-no for those archs that still use -traditional.
>  > > I dunno if this is a problem for you at the moment and the
>  > > right fix is anyway to nuke -traditional.
>  > > 
>  > >     Sam
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> CC: Sam Ravnborg <sam@ravnborg.org>
> CC: lethal@linux-sh.org
> CC: linux-sh@vger.kernel.org
> ---
>  arch/sh/boot/compressed/Makefile_32 |    1 -
>  arch/sh/boot/compressed/Makefile_64 |    1 -
>  2 files changed, 2 deletions(-)
> 
Oops, these must have snuck back in during the sh64 integration, I
thought I had killed them all off already. Applied, thanks.
