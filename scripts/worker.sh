#!/bin/bash
QUEUE="data/antrean.txt"
LOCK="/tmp/worker.lock"

exec 200>"$LOCK"
flock -n 200 || { echo "Worker lain sedang berjalan. Ditolak."; exit 1; }

while [ -s "$QUEUE" ]; do
	JOB=$(head -n 1 "$QUEUE")
	echo "Memproses: $JOB"
	bash -c "$JOB"
	sed -i '1d' "$QUEUE"
done

echo "Antrean kosong."

