From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 23 Mar 2011 13:25:06 +0000
Subject: Re: [PATCH] sh: Fix ptrace fpu state initialisation
Message-Id: <20110323132506.GA17693@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <AB12B32E73474741A2C5361C433A44DE02911887@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
In-Reply-To: <AB12B32E73474741A2C5361C433A44DE02911887@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 18, 2011 at 02:16:31PM +0000, Phil Edworthy wrote:
> Commit 0ea820cf introduced the PTRACE_GETFPREGS/SETFPREGS cmds,
> but gdb-server still accesses the FPU state using the
> PTRACE_PEEKUSR/POKEUSR commands. In this case, xstate was not
> initialised.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Applied, thanks.
