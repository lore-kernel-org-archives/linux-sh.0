From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Dec 2009 04:46:03 +0000
Subject: Re: [PATCH] sh: fix sh7724 VEU3F resource size
Message-Id: <20091204044603.GI11047@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091201133852.29252.62066.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091201133852.29252.62066.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 01, 2009 at 10:38:52PM +0900, Magnus Damm wrote:
> Fix one-off VEU3F size error for sh7724.

On Thu, Dec 03, 2009 at 09:31:45PM +0900, Magnus Damm wrote:
> This patch updates the Runtime PM code for SuperH Mobile
> to allow drivers to have NULL as pm or callback value.
> With this in place there is no need for no-op functions.

Both applied, thanks.
