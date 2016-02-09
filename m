From: Hamza Farooq <hamzahfrq.sub@gmail.com>
Date: Tue, 09 Feb 2016 09:47:39 +0000
Subject: Programmable clock in salvator-x
Message-Id: <CAJ--JmwGfEg+UES_ivs5avsoyaYPQoJf+ZKu1spOE-J1LAhaEQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

in order to use IDT 5P49V5923A programmable clock for DU, I was
wondering if the driver for it is already available/present in the
Linux source tree. It seems to be present on the board but not
used/enabled from salvator-x device tree.

programable_clk0 and programable_clk01 seem to be used in du node but
not associated with IDT clock chip. Or am I overlooking something?

Thanks and best regards,
Hamza
