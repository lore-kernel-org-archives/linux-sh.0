From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 01 Apr 2010 16:15:11 +0000
Subject: O_DIRECT not found.
Message-Id: <201004011815.12072.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h> /* Standard input/output definitions */
#include <string.h> /* String function definitions */
#include <unistd.h> /* UNIX standard function definitions */
#include <fcntl.h> /* File control definitions */
#include <errno.h> /* Error number definitions */
#include <termios.h>

.
.
.



rs485TxEn_fd = open("/proc/mlcdports/rs485txen",O_WRONLY | O_NDELAY | 
O_DIRECT);

.
.
.

Why I cannot find the flag O_DIRECT

Thanks a lot
-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
