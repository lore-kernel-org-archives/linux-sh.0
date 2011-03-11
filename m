From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Mar 2011 03:40:35 +0000
Subject: Re: [PATCH] shmobile: Rename cpuidle states to fit to general conventions
Message-Id: <20110311034035.GC8065@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1298842606-55712-1-git-send-email-trenn@suse.de> <1298842606-55712-2-git-send-email-trenn@suse.de>
In-Reply-To: <1298842606-55712-2-git-send-email-trenn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, mingo@elte.hu, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Sun, Feb 27, 2011 at 10:36:42PM +0100, Thomas Renninger wrote:
> C0 is known as "busy", "not idle" state.
> X86 "busy polling" state also got renamed from C0
> to "POLL" recently.
> Let's stay consistent with naming to avoid confusions.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Acked-by: Magnus Damm <damm@opensource.se>
> CC: linux-sh@vger.kernel.org

Fine with me. Applied, thanks.
