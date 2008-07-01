From: Nicholas Beck <nbeck@mpc-data.co.uk>
Date: Tue, 01 Jul 2008 10:33:11 +0000
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board
Message-Id: <486A07E7.1070906@mpc-data.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20080321111630.13138.14500.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080321111630.13138.14500.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: magnus.damm@gmail.com
Cc: linux-sh@vger.kernel.org, linux-input@vger.kernel.org

Hi Magnus,

Firstly, thanks for the great work. I have one issue with the touch
screen driver for the MigoR board though.

I don't get any BTN_TOUCH release events using the touch screen driver
for the MigoR board. Do you experience the same problem?

I only see the first BTN_TOUCH down and then the absolute x-y pairs. The
input framework gobbles up the subsequent BTN_TOUCH down events until it
detects a BTN_TOUCH release event, as it should do. But the release
event does not occur at the moment (for me at least), so a tap cannot be
performed.

I have a patch that adds a timer to perform the BTN_TOUCH release event
(kind of like a WDT), that I can submit if this is of any interest?

Thanks in advance,
Nicholas Beck
