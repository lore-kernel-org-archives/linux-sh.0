From: Ralf Baechle <ralf@linux-mips.org>
Date: Wed, 17 Mar 2010 15:39:18 +0000
Subject: Re: [PATCH 42/66] arch/mips/lib/libgcc.h: Checkpatch cleanup
Message-Id: <20100317153918.GD4554@linux-mips.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
 <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org

On Sat, Feb 27, 2010 at 05:51:23PM +0100, Andrea Gelmini wrote:
> From: Andrea Gelmini <andrea.gelmini@gelma.net>
> Date:   Sat, 27 Feb 2010 17:51:23 +0100
> To: linux-kernel@vger.kernel.org
> Cc: Andrea Gelmini <andrea.gelmini@gelma.net>,
> 	Ralf Baechle <ralf@linux-mips.org>,
> 	Paul Mundt <lethal@linux-sh.org>, linux-mips@linux-mips.org,
> 	linux-sh@vger.kernel.org
> Subject: [PATCH 42/66] arch/mips/lib/libgcc.h: Checkpatch cleanup
> 
> arch/mips/lib/libgcc.h:21: ERROR: open brace '{' following union go on the same line
> 
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  arch/mips/lib/libgcc.h |    3 +--
>  arch/sh/lib/libgcc.h   |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

I've applied the MIPS portion of the patch, thanks.

  Ralf
