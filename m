From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 28 Oct 2011 06:14:09 +0000
Subject: Re: [PATCH/linux-next] sh: userimask.c needs linux/stat.h
Message-Id: <20111028061409.GH32187@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1317691041-20226-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1317691041-20226-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 04, 2011 at 10:17:21AM +0900, Nobuhiro Iwamatsu wrote:
> This fix the problem that S_IRUSR and S_IWUSR are not solved in userimask.c.
> 
> -----
> CC      drivers/usb/host/r8a66597-hcd.o
> drivers/sh/intc/userimask.c:57: error: ???S_IRUSR??? undeclared here (not in a function)
> drivers/sh/intc/userimask.c:57: error: ???S_IWUSR??? undeclared here (not in a function)
> CC      drivers/watchdog/shwdt.o
> -----
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Applied, thanks.
