From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 07 Jul 2008 04:08:19 +0000
Subject: Re: [PATCH] sh: add SuperH Mobile I2C platform data to sh7343
Message-Id: <20080707040819.GB7601@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080705033146.17251.47676.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080705033146.17251.47676.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jul 05, 2008 at 12:31:46PM +0900, Magnus Damm wrote:
> This patch adds platform data for two I2C channels to the sh7343.

On Sat, Jul 05, 2008 at 12:32:06PM +0900, Magnus Damm wrote:
> This patch adds platform data for the single I2C channel on sh7723.

On Sat, Jul 05, 2008 at 12:32:23PM +0900, Magnus Damm wrote:
> This patch adds platform data for the single I2C channel on sh7366.

On Sat, Jul 05, 2008 at 12:32:44PM +0900, Magnus Damm wrote:
> This patch enables I2C on the sh7723-based ap325rxa board.

On Sat, Jul 05, 2008 at 12:33:30PM +0900, Magnus Damm wrote:
> Remove inline from ptep_get_and_clean() to match with header file prototype.
> Makes linux-next build.

Applied, thanks.
