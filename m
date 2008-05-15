From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 15 May 2008 04:26:46 +0000
Subject: Re: fix memcpy-sh4.S
Message-Id: <20080515042646.GB2260@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080514.103812.68564161.saito@densan.co.jp>
In-Reply-To: <20080514.103812.68564161.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 14, 2008 at 10:38:12AM +0900, Hideo Saito wrote:
> In the code on memcpy-sh4.S with big endian, it seems that the
> following fix is needed.
> 
Applied, thanks.
