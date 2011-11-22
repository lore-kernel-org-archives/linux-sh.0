From: phil.edworthy@renesas.com
Date: Tue, 22 Nov 2011 10:32:41 +0000
Subject: sh-sci CTS problem
Message-Id: <OFB48B001D.3AA44CAE-ON80257950.0037E14A-80257950.0039B579@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Yoshii-san, Paul,

Commit 4480a688 is a problem for some devices. For example, on the SH7203 
some serial ports have RTS/CTS, but others don't.

I guess the right thing to do is add an extra field to struct 
plat_sci_port to indicate support for RTS/CTS?

Phil
