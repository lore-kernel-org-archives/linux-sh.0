From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 02 Apr 2016 12:51:59 +0000
Subject: Re: [PATCH v3 09/11] i2c: rcar: revoke START request early
Message-Id: <56FFC06F.70108@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
 <1447948611-2615-10-git-send-email-wsa@the-dreams.de>
 <56FD9080.4090203@cogentembedded.com> <20160331224838.GA7381@katana>
 <56FED245.4010503@cogentembedded.com> <20160401201415.GA25936@katana>
 <56FEFEC4.6010401@cogentembedded.com> <20160402072726.GA1384@katana>
In-Reply-To: <20160402072726.GA1384@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

On 4/2/2016 10:27 AM, Wolfram Sang wrote:

>>     Thanks again! I ended up backporting all the patches up to #9. Not sure
>> it'd be acceptable for the -stable kernels since there's a lot of refactors
>> involved...
>
> That's what I thought, too.

    And I still don't feel good about the patch removing the spinlock -- I'm 
not sure it's SMP-safe...

MBR, Sergei

