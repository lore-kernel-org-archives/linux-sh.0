From: CHIKAMA Masaki <masaki.chikama@gmail.com>
Date: Mon, 15 Jun 2009 14:58:47 +0000
Subject: mmap address alignment when mmaping MAP_SHARED | MAP_FIXED
Message-Id: <fd0635d10906150758w4f0c7d01q92d8e31546c976f1@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello all.

On current sh kernel,  mmaped  address must be aligned 16KB boundary
instead of getpagesize()
when mmaping MAP_SHARED|MAP_FIXED. Can you removed this limitation ?

Please look at this.
 http://sourceware.org/bugzilla/show_bug.cgi?id283

Best regards.
-- 
CHIKAMA Masaki
