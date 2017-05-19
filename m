From: riel@redhat.com
Date: Fri, 19 May 2017 21:26:31 +0000
Subject: stackprotector: ascii armor the stack canary
Message-Id: <20170519212636.30440-1-riel@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Zero out the first byte of the stack canary value on 64 bit systems,
in order to prevent unterminated C string overflows from being able
to successfully overwrite the canary, even if an attacker somehow
guessed or obtained the canary value.

Inspired by execshield ascii-armor and PaX/grsecurity.

Thanks to Daniel Micay for extracting code of similar functionality
from PaX/grsecurity and making it easy to find in his linux-hardened
git tree on https://github.com/thestinger/linux-hardened/

