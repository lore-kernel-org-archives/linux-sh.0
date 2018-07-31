From: Rob Landley <rob@landley.net>
Date: Tue, 31 Jul 2018 16:36:46 +0000
Subject: Re: [PATCH QEMU] hw/char/sh_serial: Add timeout handling to unbreak serial input
Message-Id: <97622558-a520-6ab2-b61f-8038ae61b451@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20180730130234.30020-1-geert+renesas@glider.be>
 <1115027626.150336.1532963923061@webmail.strato.com>
In-Reply-To: <1115027626.150336.1532963923061@webmail.strato.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <uli@fpond.eu>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

On 07/30/2018 10:18 AM, Ulrich Hecht wrote:>> On July 30, 2018 at 3:02 PM Geert
Uytterhoeven <geert+renesas@glider.be> wrote:
>> Fix this by adding basic timeout handling.  As the QEMU SCIF emulation
>> ignores any serial speed programming, the timeout value used conforms to
>> a default speed of 9600 bps, which is fine for any interative console.
>>
>> Reported-by: Rob Landley <rob@landley.net>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Works for me, kernel 4.18-rc7 for rts7751r2dplus.

Works for me too.

Tested-by: Rob Landley <rob@landley.net>

Rob
