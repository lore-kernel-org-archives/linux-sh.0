From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 04 Jun 2020 08:54:18 +0000
Subject: Kernel doesn't boot on qemu-sh4
Message-Id: <364fae0d-6030-6741-d38a-3e6fd15fc4ca@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Has anyone had any success booting a current kernel on qemu-sh4?

I have built a Debian kernel with both my patch to add __get_user_u64() as
well as the two patches by Romain Naour [1,2] but the kernel still doesn't
boot for me.

Am I missing anything?

Adrian

> [1] https://marc.info/?l=linux-sh&m8429470120959&w=2
> [2] https://marc.info/?l=linux-sh&m8429470221261&w=2

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
