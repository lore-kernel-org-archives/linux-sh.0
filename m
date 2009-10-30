From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 30 Oct 2009 03:38:22 +0000
Subject: Re: [PATCH 00/07] sh: SuperH Mobile Sleep Mode Rewrite Part 1/2
Message-Id: <20091030033822.GB1824@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091029105131.29078.26418.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091029105131.29078.26418.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 29, 2009 at 07:51:31PM +0900, Magnus Damm wrote:
> [PATCH 02/07] sh: Add notifiers chains for cpu/board code
> [PATCH 03/07] sh: Add sh7724 notifier for R-standby save/restore
> [PATCH 04/07] sh: Allow boards to register memory pre/post sleep code
> [PATCH 05/07] sh: Add kfr2r09 specific memory pre/post sleep code
> [PATCH 06/07] sh: Add ms7724se specific memory pre/post sleep code
> [PATCH 07/07] sh: Add migor specific memory pre/post sleep code
> 
2-7 applied. 1/7 was dropped and the rest were updated to use the old
name, as discussed off-list.
