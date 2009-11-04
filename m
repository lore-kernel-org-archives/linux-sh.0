From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 04 Nov 2009 03:14:42 +0000
Subject: Re: [PATCH] sh: Add RWDT save/restore code for sh7724 R-standby
Message-Id: <20091104031442.GE12841@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091102093103.19544.17850.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091102093103.19544.17850.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 02, 2009 at 06:31:03PM +0900, Magnus Damm wrote:
> Add sh7724 code to save and restore RWDT state during
> R-standby. Without this patch the watchdog will generate
> a reset shortly after resuming from R-standby.

Applied, thanks.
