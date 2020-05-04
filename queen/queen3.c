#include <stdio.h>
#include <time.h>
#include <stdint.h>

#if defined(WIN32) || defined(_WIN32) || defined(WIN64) || defined(_WIN64)
#include <windows.h>
#else
#include <sys/time.h>
#include <sched.h>
#include <unistd.h>
#include <pthread.h>
#ifndef __unix
#define __unix 1
#endif
#endif

int64_t clock_realtime(void)
{
	int64_t sec, usec;
#if defined(WIN32) || defined(_WIN32) || defined(WIN64) || defined(_WIN64)
	typedef void (WINAPI * GetSystemTime_t)(LPFILETIME);
	static GetSystemTime_t GetSystemTime_p = NULL;
	static int64_t epoch = 0;
	static volatile int inited = 0;
	LARGE_INTEGER ularge;
	FILETIME file_time;
	int64_t current;
	if (inited == 0) {
		ularge.HighPart = 0x019db1de;
		ularge.LowPart = 0xd53e8000;
		epoch = (int64_t)ularge.QuadPart;
		GetSystemTime_p = (GetSystemTime_t)GetProcAddress(
				GetModuleHandle(TEXT("kernel32.dll")),
				"GetSystemTimePreciseAsFileTime"
				);
		inited = 1;	
	}
	if (GetSystemTime_p == NULL) {
		GetSystemTimeAsFileTime(&file_time);
	}
	else {
		GetSystemTime_p(&file_time);
	}
	ularge.LowPart = file_time.dwLowDateTime;
	ularge.HighPart = file_time.dwHighDateTime;
	current = ((int64_t)ularge.QuadPart) - epoch;
	sec = (int64_t)(current / 10000000);
	usec = (int64_t)((current % 10000000) / 10);
#else
	struct timeval time;
	gettimeofday(&time, NULL);
	sec = (int64_t)(time.tv_sec);
	usec = (int64_t)(time.tv_usec);
#endif
	return (sec * 1000000) + (usec % 1000000);
}

void isleep(unsigned long millisecond)
{
#ifdef __unix 	/* usleep( time * 1000 ); */
	#if 0
	struct timespec ts;
	ts.tv_sec = (time_t)(millisecond / 1000);
	ts.tv_nsec = (long)((millisecond % 1000) * 1000000);
	nanosleep(&ts, NULL);
	#else
	usleep((millisecond << 10) - (millisecond << 4) - (millisecond << 3));
	#endif
#elif defined(_WIN32)
	Sleep(millisecond);
#endif
}


#define N  15

static inline int abs(int x) {
	return (x < 0)? (-x) : x;
}

int check(int *q, int row)
{
	if (row == 0) {
		return 1;
	}	else {
		int y;
		int x0 = q[row];
		for (y = 0; y < row; y++) {
			int x = q[y];
			if (x == x0)
				return 0;
			else if (abs(x - x0) == row - y)
				return 0;
		}
	}
	return 1;
}

int queen()
{
	int q[N] = {0};
	int found = 0;
	int row = 0;
	int done = 0;
	while (done == 0) {
		if (check(q, row)) {
			if (row == N - 1) {
				found++;
			}	else {
				row++;
				q[row] = 0;
				continue;
			}
		}
		q[row] += 1;
		while (q[row] >= N) {
			row--;
			if (row >= 0) {
				q[row]++;
			}	else {
				done = 1;
				break;
			}
		}
	}
	return found;
}

int main(void)
{
	clock_realtime();
	{
		int found;
		queen();
		isleep(1000);
		int64_t ts = clock_realtime();
		found = queen();
		ts = clock_realtime() - ts;
		printf("found=%d time=%.3fms\n", found, ts * 0.001);
	}
	return 0;
}


