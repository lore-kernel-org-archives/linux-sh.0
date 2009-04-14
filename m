From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Apr 2009 09:17:22 +0000
Subject: Re: [PATCH 1/6] Add support for SH7724 CPU subtype
Message-Id: <20090414091721.GA30402@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 14, 2009 at 05:14:39PM +0900, Kuninori Morimoto wrote:
> This adds preliminary support for the SH7724 CPU subtype.
> This patch is based on Rev 0.11 manual
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Please resend this patch series with the timestamps corrected and
properly nested. They are not only completely out of order, but do not
nest at all. Even if you just have a 0/6 mail that summarizes the patch
set and all of the other patches nest under that, it makes it a lot
easier to figure out where things are supposed to go.
