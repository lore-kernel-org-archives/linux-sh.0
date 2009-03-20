From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 20 Mar 2009 15:18:52 +0000
Subject: Re: [PATCHv2 1/2] sh: add support for SMSC Polaris platform
Message-Id: <20090320151852.GC13269@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1237558590-22106-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1237558590-22106-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 20, 2009 at 02:16:29PM +0000, Steve Glendinning wrote:
> Polaris is an SMSC reference platform with a SH7709S CPU and LAN9118
> ethernet controller.  This patch adds support for it.
> 
> Updated following feedback from Nobuhiro Iwamatsu.
> 
> Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>

Looks good, I'll roll the defconfig patch in with this and add
Iwamatsu-san's Reviewed-by. It will be part of the -rc1 merge.
