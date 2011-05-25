From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 25 May 2011 02:49:09 +0000
Subject: Re: [PATCH 3/3 v3] sh_mobile_meram: MERAM platform data for LCDC
Message-Id: <20110525024908.GH14329@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1306220482-29107-4-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1306220482-29107-4-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 24, 2011 at 04:01:22PM +0900, Damian Hobson-Garcia wrote:
> Based on the patch by Takanari Hayama <taki@igel.co.jp>
> 
> Add the necessary platform data to add MERAM functionality to LCDC
> 
> Includes platform data for both the AP4EVB and mackerel
> 
> Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>

I've merged the common/fbdev-meram changes in to rmobile/fbdev and
applied this on top. You should be able to do integration testing there
if you wish, otherwise I'll merge it in for -rc2 once the other parts
have settled upstream.
