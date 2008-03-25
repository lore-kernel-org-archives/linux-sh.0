From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Mar 2008 07:56:11 +0000
Subject: Re: [PATCH 05/06] sh: MigoR NOR flash support using physmap-flash
Message-Id: <20080325075611.GA29509@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080321094355.10532.43880.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080321094355.10532.43880.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 21, 2008 at 06:43:55PM +0900, Magnus Damm wrote:
> Add NOR flash support to the MigoR board by giving board specific data
> to the physmap-flash platform driver.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

On Fri, Mar 21, 2008 at 06:44:04PM +0900, Magnus Damm wrote:
> Add NAND flash support to the MigoR board by giving board specific data
> to the gen_nand platform driver.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

After some mangling, these are now applied also.
