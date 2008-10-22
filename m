From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 22 Oct 2008 11:12:35 +0000
Subject: Re: [PATCH] sh: use 10MHz VIO_CLK for ov772x on Migo-R
Message-Id: <20081022111234.GA14398@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081022092539.1072.78186.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081022092539.1072.78186.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 22, 2008 at 06:25:39PM +0900, Magnus Damm wrote:
> Use a slower VIO_CKO clock frequency for the ov772x on Migo-R.
> This improves the camera picture quality on Panel Board V2.1.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

On Wed, Oct 22, 2008 at 06:29:17PM +0900, Magnus Damm wrote:
> This patch improves the support for gpio pins that are hard wired
> to either input or output and lack control register association.
> A special force enum id is used to allow use without control
> register but still mark the gpio pin as input or output.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied, thanks.
